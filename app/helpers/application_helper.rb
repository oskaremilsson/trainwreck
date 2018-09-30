module ApplicationHelper
    def is_admin?
        head :not_found unless session[:is_admin]
    end
    
    def filter?
        params[:filter] && params[:on]
    end

    def valid_filter?
        if Course.column_names.include? params[:filter]
            true
        else
            false
        end
    end
end
