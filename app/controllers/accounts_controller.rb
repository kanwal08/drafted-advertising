class AccountsController < ApplicationController

  def amazon
    @profile_metrics = ProfileMetricSummary.includes(profile: [:marketplace, :account]).order('accounts.name')
    @profile_metrics = @profile_metrics.where('accounts.name ilike ? or marketplaces.country_code ilike ? or accounts.account_type ilike ?', "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%") if params[:q].present?
    @profile_metrics = @profile_metrics.where('accounts.account_type = ?', params[:account_type]) if params[:account_type].present?
    @profile_metrics = @profile_metrics.where('profiles.is_actively_managed = ?', params[:is_actively_managed]) if params[:is_actively_managed].present?
    if params[:range]

    end
  end
end
