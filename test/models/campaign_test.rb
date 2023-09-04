# == Schema Information
#
# Table name: campaigns
#
#  id                     :bigint           not null, primary key
#  last_retrieved_at      :datetime
#  name                   :string
#  campaign_external_id   :string
#  campaign_type          :string
#  targeting_type         :string
#  premium_bid_adjustment :boolean
#  daily_budget           :decimal(, )
#  start_date             :date
#  state                  :string
#  bidding_strategy       :string
#  profile_id             :bigint
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require "test_helper"

class CampaignTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
