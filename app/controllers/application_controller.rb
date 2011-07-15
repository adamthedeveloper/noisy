class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def current_profile
    @profile ||= Profile.find_by_account_id(current_account.id)
  end

  def logged_in?
    current_account.present?
  end

  def after_sign_in_path_for(resource)
    profile_path(current_profile)
  end
end
