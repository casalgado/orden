class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # El siguiente method es para determinar adonde va devise leugo del sign-in

  def after_sign_in_path_for(resource)
    tasks_path(resource)
  end

  # De aqui hasta -- es para agregar custom fields a devise

  before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters
	  devise_parameter_sanitizer.for(:sign_up) << :first_name
	  devise_parameter_sanitizer.for(:sign_up) << :last_name

    # devise_parameter_sanitizer.for(:account_update) << :first_name
    # devise_parameter_sanitizer.for(:account_update) << :last_name
  end

  # --

end
