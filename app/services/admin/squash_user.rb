module Admin
  class SquashUser < ApplicationService
    def initialize(params = {})
      @params = params
    end

    def call
      return unless schema.call(params).success?
      return if squashed_user_id == into_user_id

      transaction do
        fix_has_many_dependencies!
        destroy_squashed_user!
      end

      true
    end

    def dependencies
      {
        has_many: {
          ::Identity     => :user_id,
          ::Donation     => :user_id,
          ::Talk         => :speaker_id,
          ::VisitRequest => :user_id
        }
      }
    end

    private

    def squashed_user_id
      params.fetch(:squashed_user_id)
    end

    def into_user_id
      params.fetch(:into_user_id)
    end

    attr_reader :params, :result

    def fix_has_many_dependencies!
      dependencies[:has_many].each_pair do |resource, key|
        resource.where(key => squashed_user_id).update_all(key => into_user_id)
      end
    end

    def destroy_squashed_user!
      DeleteUserData.(squashed_user_id)
    end

    def schema
      @schema ||= Dry::Validation.Schema do
        required(:squashed_user_id).filled
        required(:into_user_id).filled
      end
    end
  end
end
