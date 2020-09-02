class ApplicationController < ActionController::Base
	include Pundit
	rescue_from Pundit::NotAuthorizedError, with: :pundit_error
	before_action :cek_permit, if: :devise_controller?

	private

	def pundit_error
		flash[:notice] = 'Tidak memiliki Hak akses'
		redirect_to root_path
	end

	def cek_permit
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
	end
end
