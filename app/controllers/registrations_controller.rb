class RegistrationsController < Devise::RegistrationsController
# POST /resource/sign_up
  def create
    build_resource

    if resource.save
      if resource.active?
        set_flash_message :notice, :signed_up
        sign_in_and_redirect(resource_name, resource)
      else
        set_flash_message :notice, :inactive_signed_up, :reason => resource.inactive_message.to_s
        redirect_to after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords(resource)
      set_flash_message :alert, :problem_creating_account
      redirect_to new_account_session_path
    end
  end
end