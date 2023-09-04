# == Schema Information
#
# Table name: api_accounts
#
#  id                      :bigint           not null, primary key
#  name                    :string
#  encrypted_refresh_token :string
#  encrypted_access_token  :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  access_token_expires_at :datetime
#
class ApiAccount < ApplicationRecord
  encrypts :encrypted_refresh_token, :encrypted_access_token

  has_many :profiles
end
