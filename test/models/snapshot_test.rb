# == Schema Information
#
# Table name: snapshots
#
#  id                   :bigint           not null, primary key
#  snapshot_type        :string
#  snapshot_external_id :string
#  status               :string
#  profile_id           :bigint
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
require "test_helper"

class SnapshotTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
