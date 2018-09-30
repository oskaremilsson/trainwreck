class LoginController < ApplicationController
    require 'digest/sha1'

    def index
    end

    def login
        session[:is_admin] = is_admin?

        data = {
            admin: session[:is_admin]
        }
        
        render :json => data
    end

    def logout
        session[:is_admin] = false
        render :json => { admin: false }
    end

    private
        def is_admin?
            password_hash = Digest::SHA1.hexdigest(params[:login][:password])
            Admin.where(username: params[:login][:username], password: password_hash).first.present?
        end

        def login_params
            params.require(:login).permit(:username, :password)
        end
end
