# == Schema Information
#
# Table name: accounts
#
#  id           :bigint           not null, primary key
#  name         :string
#  account_type :string
#  external_id  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  region_id    :bigint           not null
#
class Account < ApplicationRecord
  belongs_to :region
  has_many :profiles
end
