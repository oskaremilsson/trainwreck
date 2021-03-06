class CoursesController < ApplicationController

    def index
        errors = []
        if filter?
            if valid_filter?
                courses = Course.where(params[:filter] => params[:on])
                errors.push('no courses found') unless courses.length > 0
            else
                errors.push('filter not valid')
            end
        elsif
            courses = Course.all
            errors.push('no courses found') unless courses.length > 0
        end

        data = {
            :filtered => (filter? && valid_filter?),
            courses: courses,
            :errors => (errors if errors.any?)
        }.compact
        
        render :json => data
    end

    def show
        errors = []
        course = Course.find_by(id: params[:id])

        errors.push('course not found') unless course

        data = {
            course: course,
            :errors => (errors if errors.any?)
        }.compact

        render :json => data
    end

    def new
    end

    def create
        @course = Course.new(course_params)
 
        @course.save
        redirect_to @course
    end

    def edit
        @course = Course.find_by(id: params[:id])

        if params[:format] == 'json'
            data = {
                course: @course
            }
            render :json => data
        end
    end

    def update
        @course = Course.find_by(id: params[:id])
        if @course.update(course_params)
            redirect_to @course
        else
            render 'edit'
        end
    end

    private
        def course_params
            params.require(:course).permit(:code, :title, :credits, :state, :school, :courseplan, :description)
        end
end
