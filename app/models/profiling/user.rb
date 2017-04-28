module Profiling
  class User < ApplicationRecord
    self.table_name = :profiling_users

    include Searchable
    extend FriendlyId

    friendly_id :full_name, use: :slugged

    LATIN_LETTERS_REGEX = /[a-zA-Z]+/

    mount_uploader :cover, SpeakerCoverUploader

    scope :verified, -> { where(verified: true) }
    scope :newbies,  -> { where(verified: false) }

    has_many :donations, foreign_key: :user_id, dependent: :destroy
    has_many :talks, foreign_key: :speaker_id, dependent: :nullify
    has_many :visit_requests, foreign_key: :user_id, dependent: :destroy

    validates :id, :first_name, :last_name, :email, :slug, presence: true
    validates :first_name, :last_name, format: {
      with: LATIN_LETTERS_REGEX,  message: I18n.t('errors.only_latin_letters')
    }

    def full_name
      "#{first_name} #{last_name}"
    end

    def should_generate_new_friendly_id?
      slug.blank? || first_name_changed? || last_name_changed?
    end

    def normalize_friendly_id(string)
      count = self.class.where(first_name: first_name, last_name: last_name).count

      count > 0 ? super + '-' + (count + 1).to_s : super
    end
  end
end
