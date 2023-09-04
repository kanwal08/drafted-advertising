# == Schema Information
#
# Table name: marketplaces
#
#  id            :bigint           not null, primary key
#  name          :string
#  external_id   :string
#  country_code  :string
#  currency_code :string
#  timezone      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  region_id     :bigint
#
require "test_helper"

class MarketplaceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
