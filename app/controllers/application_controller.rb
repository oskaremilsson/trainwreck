class ApplicationController < ActionController::Base
    include ApplicationHelper
    before_action :is_admin?, only: [:new, :create, :edit]
end
