module Admin
  class User < ApplicationRecord
    include ReadonlyModel

    self.table_name = :profiling_users

    extend FriendlyId

    friendly_id :full_name, use: :slugged

    class << self
      def default_scope
        select('profiling_users.id',
               'profiling_users.email',
               'authorization_admins.id IS NOT NULL AS admin',
               'authentication_users.id IS NULL AS synthetic',
               :verified,
               :first_name,
               :last_name,
               :slug,
               :cover).
          joins(admins_join).
          joins(authentication_users_join)
      end

      private

      def admins_join
        admins = Authorization::Admin.arel_table

        arel_table.
          join(admins, Arel::Nodes::OuterJoin).
          on(admins[:id].eq(arel_table[:id])).
          join_sources
      end

      def authentication_users_join
        authentication_users = Authentication::User.arel_table

        arel_table.
          join(authentication_users, Arel::Nodes::OuterJoin).
          on(authentication_users[:id].eq(arel_table[:id])).
          join_sources
      end
    end

    scope :admin,     ->{ where.not(authorization_admins: { id: nil }) }
    scope :synthetic, ->{ where(authentication_users: { id: nil }) }
    scope :sorted,   -> { order(:last_name).order(:first_name) }

    def full_name
      "#{first_name} #{last_name}"
    end

    def reverse_full_name
      "#{last_name} #{first_name}"
    end
  end
end
