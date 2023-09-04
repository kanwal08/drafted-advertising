module AccountsHelper

  def profile_name(profile)
    profile ? "#{profile&.account&.name} - #{profile&.marketplace&.country_code}" : ""
  end

  def cost_per_click(metric)
    "$#{(metric.cost / metric.clicks).round(2)}"
  end

  def acost(metric)
    "#{(metric.cost/metric.sales_14d).round(2)}%"
  end

  def account_type_select_options
    unique_account_types = Account.pluck(:account_type).uniq # ["seller", "vendor"]
    unique_account_types.map{|type| [type.titleize, type]}.unshift ['Show All', ""]
    #[["Show All", ""], ["Seller", "seller"], ["Vendor", "vendor"]]
  end

  def managed_status_select_options
    [["Show All", ""], ["Managed", true], ["Unmanaged", false]]
  end

  def data_range_select_options
    preset_range = [7, 14, 30, 60]
    select_options = preset_range.map{|range| ["Last #{range} Days", range]}
    #[["Last 7 Days", 7], ["Last 14 Days", 14], ["Last 30 Days", 30], ["Last 60 Days", 60]]
    select_options.unshift ["Show All", ""]
  end
end