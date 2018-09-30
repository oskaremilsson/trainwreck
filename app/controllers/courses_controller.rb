class CoursesController < ApplicationController

    before_action :is_admin?, only: [:new, :create, :edit]

    def index
        if valid_filter?
            courses = Course.where(params[:filter] => params[:on])
        elsif
            courses = Course.all
        end

        data = {
            nrOfCourses: courses.length,
            filtered: valid_filter?,
            courses: courses,
            :errors => ({ error: 'no courses found' } unless courses.length > 0)
        }.compact
        
        render :json => data
    end

    def show
        course = Course.find_by(id: params[:id])

        data = {
            course: course,
            :errors => ({ error: 'course not found' } unless course)
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

        def valid_filter?
            false
            if params[:filter] && params[:on]
                if Course.column_names.include? params[:filter]
                    true
                else
                    false
                end
            else
                false
            end
        end
end
