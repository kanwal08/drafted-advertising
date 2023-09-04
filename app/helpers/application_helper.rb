# frozen_string_literal: true

module ApplicationHelper

  def alert_icon(type)
    case type
    when "success"
      "ki-shield-tick"
    when "error"
      "ki-information"
    when "warning"
      "ki-information"
    else
      "ki-notification-bing"
    end
  end
end
