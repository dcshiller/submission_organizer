# == Schema Information
#
# Table name: submissions
#
#  id         :integer          not null, primary key
#  article_id :integer
#  journal_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
