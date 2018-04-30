class Article < ApplicationRecord
  belongs_to :user
  has_many :submissions, dependent: :destroy
  has_many :submission_events, through: :submissions, source: :events
  has_many :journals, through: :submissions
  has_one :latest_article_events_by_user

  scope :submitted,  -> { distinct.joins(:submissions) }
  scope :not_accepted, -> { distinct.left_outer_joins(submissions: :events).
                                     where.not(submission_events: { event_subtype: 'acceptance' }) }

  def to_s
    title
  end

  def short_title
    title_words = title.split(" ")
    result = title_words.inject([]) { |accum, word| accum << word if accum.sum(&:size) + word.size + 2 <= 37; accum }
    result.join(" ") + '...'
  end
end
