class JobsController < ApplicationController

    before_action :is_admin?, only: [:new, :create, :edit]

    def index
        errors = []
        if filter?
            if valid_filter?
                jobs = Job.where(params[:filter] => params[:on])
                errors.push('no jobs found') unless jobs.length > 0
            else
                errors.push('filter not valid')
            end
        elsif
            jobs = Job.all
            errors.push('no jobs found') unless jobs.length > 0
        end

        data = {
            :filtered => (filter? && valid_filter?),
            jobs: jobs,
            :errors => (errors if errors.any?)
        }.compact
        
        render :json => data
    end

    def show
        errors = []
        job = Job.find_by(id: params[:id])

        errors.push('jobs not found') unless job

        data = {
            job: job,
            :errors => (errors if errors.any?)
        }.compact

        render :json => data
    end

    def new
    end

    def create
        @job = Job.new(job_params)
 
        @job.save
        redirect_to @job
    end

    def edit
        @job = Job.find_by(id: params[:id])

        if params[:format] == 'json'
            data = {
                course: @job
            }
            render :json => data
        end
    end

    def update
        @job = Job.find_by(id: params[:id])
        if @job.update(job_params)
            redirect_to @job
        else
            render 'edit'
        end
    end

    private
        def job_params
            params.require(:job).permit(:title, :startDate, :endDate, :employer, :location, :description)
        end
end
