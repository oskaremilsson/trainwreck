class SocialsController < ApplicationController

    before_action :is_admin?, only: [:new, :create, :edit]

    def index
        errors = []  
        social = Social.all
        errors.push('no social found') unless social.length > 0

        data = {
            social: social,
            :errors => (errors if errors.any?)
        }.compact
        
        render :json => data
    end

    def show
        errors = []
        social = Social.find_by(id: params[:id])

        errors.push('social not found') unless social

        data = {
            social: social,
            :errors => (errors if errors.any?)
        }.compact

        render :json => data
    end

    def new
        @social = Social.new
    end

    def create
        @social = Social.new(social_params)
    
        @social.save
        redirect_to @social
    end

    def edit
        @social = Social.find_by(id: params[:id])

        if params[:format] == 'json'
            data = {
                social: @social
            }
            render :json => data
        end
    end

    def update
        @social = Social.find_by(id: params[:id])
        if @social.update(social_params)
            redirect_to @social
        else
            render 'edit'
        end
    end

    private
        def social_params
            params.require(:social).permit(:site, :link)
        end
end
