# == Schema Information
#
# Table name: product_targetings
#
#  id                            :bigint           not null, primary key
#  last_retrieved_at             :datetime
#  expression_type               :integer
#  product_targeting_external_id :string
#  state                         :string
#  bid                           :decimal(, )
#  ad_group_id                   :bigint           not null
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#
class ProductTargeting < ApplicationRecord
  enum expression_type: { auto: 0, manual: 1 }

  # Associations
  belongs_to :ad_group
  has_many :product_targeting_metrics, dependent: :destroy

  # Scopes
  scope :auto_targeting, -> { where(expression_type: :auto) }
  scope :manual_targeting, -> { where(expression_type: :manual) }
end
