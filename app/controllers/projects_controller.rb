class ProjectsController < ApplicationController

    before_action :is_admin?, only: [:new, :create, :edit]

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
        if @project.update(project_params)
            redirect_to @project
        else
            render 'edit'
        end
    end

    private
        def project_params
            params.require(:project).permit(:title, :year, :project_type, :images, :description)
        end
end
