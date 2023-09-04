# == Schema Information
#
# Table name: profiles
#
#  id                  :bigint           not null, primary key
#  profile_external_id :string
#  inactive_at         :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  api_account_id      :bigint           not null
#  marketplace_id      :bigint
#  account_id          :bigint
#  is_actively_managed :boolean          default(FALSE)
#
require "test_helper"

class ProfileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
