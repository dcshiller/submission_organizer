class Submission < ApplicationRecord
  belongs_to :article
  belongs_to :journal

  def to_s
    journal.title
  end
end
