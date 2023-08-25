class ApplicationController < ActionController::Base
    before_action :authenticate_user!, unless: :devise_controller?

    private
    
    helper_method :current_company

    def current_company
        @current_company ||= current_user.company if user_signed_in?
    end

end
