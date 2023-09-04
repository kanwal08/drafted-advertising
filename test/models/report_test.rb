# == Schema Information
#
# Table name: reports
#
#  id                 :bigint           not null, primary key
#  report_type        :string
#  report_external_id :string
#  status             :string
#  url                :string
#  start_date         :date
#  end_date           :date
#  profile_id         :bigint
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
require "test_helper"

class ReportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
