class CoursesController < ApplicationController

  before_action :find_course, only: [:show, :edit, :update, :destroy]

  def new
    @course = Course.new
    render :new
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:notice] = "Course created successfully"
      redirect_to courses_path(@course)
    else
      render :new
    end
  end

  def index
    @courses = Course.all
  end

  def show
    @course_assignments = @course.course_assignments
    @instructors = @course.instructors
    @enrolled = @course.enrolled
    @markers = @course.markers

  end

  def edit
  end

  def update
    if @course.update course_params
      redirect_to course_path(@course)
    else
      render:edit
    end
  end

  def destroy
    CourseAssignment.where(course_id: @course.id).each do |ca|
      ca.submissions.each do |s|
        s.destroy
      end
      ca.destroy
    end

    
    CourseRole.where(course_id: @course.id).each do |cr|
      CourseAssignment.where(course_role_assigner_id: cr.id).each do |ca|
        ca.destroy
      end

      Submission.where(course_role_marker_id: cr.id).each do |s|
        s.destroy
      end
      Submission.where(course_role_submitter_id: cr.id).each do |s|
        s.destroy
      end
      cr.destroy
    end
    @course.destroy
    redirect_to :root
  end

  def archive
    @courses = Course.all
  end

  def add_attendance
    params.each do |key, value|
      if key.include? "data-"
        tmp, block, user = key.split("-")
        course_role = CourseRole.find(user)
        block = CourseBlock.find_by(date: params[:date], course_block_type: block)
        attendance = Attendance.find_by(course_block_id: course_block.id, block_id: block.id)
        attendance.is_present = value
        attendance.save
      end
    end
  end


  private

  def course_params
    params.require(:course).permit(:name, :description, :status, :course_type, :start_date, :end_date)
  end

  def find_course
    @course = Course.find params[:id]
  end
end
