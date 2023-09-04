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
# https://developer-docs.amazon.com/sp-api/docs/marketplace-ids

class Marketplace < ApplicationRecord
  has_many :profiles
  belongs_to :region
end
