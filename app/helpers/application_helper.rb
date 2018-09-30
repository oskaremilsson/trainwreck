module ApplicationHelper
    def is_admin?
        head :not_found unless session[:is_admin]
    end
end
