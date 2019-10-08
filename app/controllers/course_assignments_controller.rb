class CourseAssignmentsController < ApplicationController
    before_action :find_course_assignment, only: [:show, :edit, :update, :destroy]

    def index
        @course = Course.find(params[:course_id])
    end

    def new 
        @course = Course.find(params[:course_id])
        @assignments = Assignment.all.select do |assignment|
            true
            # !(@course_assignment.course.course_assignments.map(&:id).include? assignment.id)
        end
        @course_assignment = CourseAssignment.new due_date: Time.now + 1.days
    end
    
    def create
        @course = Course.find(params[:course_id])
        @course_assignment = CourseAssignment.new(params.require(:course_assignment).permit(:due_date, :assignment_id, :is_active))
        @course_assignment.course = @course
        @course_assignment.assign_date = DateTime.now
        if @course_assignment.save
            redirect_to :root
        else
            render :new
        end
    end

    def edit
        @course = Course.find(params[:course_id])
        @assignments = Assignment.all
    end

    def update
        @course = Course.find(params[:course_id])
        if @course_assignment.update(params.require(:course_assignment).permit(:due_date, :assignment_id, :is_active))
            redirect_to course_course_assignment_path(@course, @course_assignment)
        else
            render :edit
        end
    end

    def destroy
        if @course_assignment.destroy
            redirect_to @course_assignment.course
        else
            redirect_to @course_assignment
        end
    end

    def show
    end 

    private
    def find_course_assignment
        @course_assignment = CourseAssignment.find(params[:id])
    end

end
