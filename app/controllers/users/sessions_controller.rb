# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  layout 'devise'

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    accounts_amazon_path
  end
end
