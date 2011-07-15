module AccountHelper
  def link_to_sign_in
    return link_to "Sign In", new_account_session_path unless current_account.present?
    link_to "Log out", destroy_account_session_path
  end
end