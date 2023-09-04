# == Schema Information
#
# Table name: ad_groups
#
#  id                   :bigint           not null, primary key
#  last_retrieved_at    :datetime
#  name                 :string
#  ad_group_external_id :string
#  default_bid          :decimal(, )
#  state                :string
#  campaign_id          :bigint
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class AdGroup < ApplicationRecord
    belongs_to :campaign
    has_many :keywords
    has_many :product_targetings
end
