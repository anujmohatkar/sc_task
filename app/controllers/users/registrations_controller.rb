class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      if resource.persisted?
        sign_out(resource)
        flash[:notice] = "Please confirm your account creation by visiting the link in the sent mail."
        redirect_to new_user_session_path and return
      end
    end
  end
end