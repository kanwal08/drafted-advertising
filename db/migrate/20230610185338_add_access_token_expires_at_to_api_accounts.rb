class AddAccessTokenExpiresAtToApiAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :api_accounts, :access_token_expires_at, :datetime
  end
end
