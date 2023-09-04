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
class Snapshot < ApplicationRecord
    belongs_to :profile
end
