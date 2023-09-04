class AddRegionRefToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_reference :accounts, :region, null: true, foreign_key: true

    Account.find_each do |account|
      profile = account.profiles.joins(:marketplace).first
      if profile.present?
        account.update!(region_id: profile.marketplace.region_id)
      end
    end

    change_column_null :accounts, :region_id, false
  end
end
