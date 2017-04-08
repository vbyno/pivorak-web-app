class Talk < ApplicationRecord
  include ::Searchable
  include Publishable

  extend FriendlyId
  friendly_id :title, use: :slugged

  acts_as_taggable

  belongs_to :event
  belongs_to :speaker, class_name: 'Profiling::User'
  belongs_to :group

  scope :sorted, -> { order(:title) }
  scope :by_speaker_id, ->(speaker_id) { where(speaker_id: speaker_id) }

  validates :title, presence: true

  # Issue: https://github.com/mbleigh/acts-as-taggable-on/issues/91#issuecomment-168273770
  def tag_list
    @tag_list ||= ActsAsTaggableOn::TagList.new tags.collect(&:name)
  end
end
