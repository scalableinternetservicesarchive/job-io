class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

     def configure_permitted_parameters
          devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :resume, :password_confirmation, :first_name, :last_name)}

          devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :password_confirmation, :first_name, :last_name, :resume_link, :summary, :resume)}
     end

     def after_sign_in_path_for(resource)
          if resource.class == User
               edit_user_registration_path
          elsif resource.class == Admin
               new_company_path
          else
               new_user_session_path
          end     
     end
     
end
