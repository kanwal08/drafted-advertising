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
class Profile < ApplicationRecord
  belongs_to :api_account
  belongs_to :marketplace
  belongs_to :account
  has_many :campaigns
  has_many :snapshots
  has_many :reports
  has_many :profile_keyword_metric_summaries
  has_many :profile_product_targeting_metric_summaries
  has_many :profile_metric_summaries

  default_scope -> { where(inactive_at: nil) }

  def active?
    inactive_at.nil?
  end
end
