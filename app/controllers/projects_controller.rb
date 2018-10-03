class ProjectsController < ApplicationController

    def index
        errors = []
        if filter?
            if valid_filter?
                projects = Project.where(params[:filter] => params[:on])
                errors.push('no project found') unless projects.length > 0
            else
                errors.push('filter not valid')
            end
        elsif
            projects = Project.all

            projects.each do |project|
                project.images = MultiJson.load(project.images) unless project.images.empty?
            end

            errors.push('no projects found') unless projects.length > 0
        end

        data = {
            :filtered => (filter? && valid_filter?),
            projects: projects,
            :errors => (errors if errors.any?)
        }.compact
        
        render :json => data
    end

    def show
        errors = []
        project = Project.find_by(id: params[:id])
        project.images = MultiJson.load(project.images) unless project.images.empty?

        errors.push('project not found') unless project

        data = {
            project: project,
            :errors => (errors if errors.any?)
        }.compact

        render :json => data
    end

    def new
    end

    def create
        @project = Project.new(project_params)
        return render 'new' unless valid_images?

        @project.save
        redirect_to @project
    end

    def edit
        @project = Project.find_by(id: params[:id])

        if params[:format] == 'json'
            data = {
                project: @project
            }
            render :json => data
        end
    end

    def update
        @project = Project.find_by(id: params[:id])
        return render 'edit' unless valid_images?

        if @project.update(project_params)
            redirect_to @project
        else
            render 'edit'
        end
    end

    private
        def valid_images?
            images = params[:project][:images]
            return true if images.empty?
            begin
                MultiJson.load(images) if images.is_a?(String)
                true
            rescue MultiJson::ParseError => e
                false
            end
        end

        def project_params
            params.require(:project).permit(:title, :year, :project_type, :images, :description)
        end
end
