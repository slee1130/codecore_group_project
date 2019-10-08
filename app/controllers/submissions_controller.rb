class SubmissionsController < ApplicationController

    before_action :find_submission, only: [:edit, :update, :destroy, :edit_grade, :update_grade, :new_grade, :create_grade, :destroy_grade]

    def index
        # Only the instructor would be able to see this page

        @course_assignment = CourseAssignment.find(params[:course_assignment_id])
        @submissions = Submission.where(course_assignment_id: @course_assignment.id)
    end

    def new
        @submission = Submission.new
        @submission.course_assignment_id = params[:course_assignment_id]
    end

    def create
        @submission = Submission.new params.require(:submission).permit(:submission_url).merge(
            course_assignment_id: params[:course_assignment_id],
            course_role_submitter_id: current_user.current_course_role.id,
            submission_date: DateTime.now
        )
        if @submission.save
            redirect_to course_course_assignment_path(@submission.course, @submission.course_assignment)
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @submission.update params.require(:submission).permit(:submission_url).merge(
            submission_date: DateTime.now
        )
            redirect_to course_course_assignment_submissions_path(@submission.course, @submission.course_assignment)
        else
            render :edit
        end
    end

    def destroy
        if @submission.destroy
            redirect_to course_course_assignment_path(@submission.course, @submission.course_assignment)
        end
    end

    def new_grade
        @submission
    end

    def create_grade
        if @submission.update params.require(:submission).permit(:feedback, :score).merge(course_role_marker_id: current_user.current_course_role.id)
            redirect_to course_course_assignment_submissions_path(@submission.course, @submission.course_assignment)
        else
            render :new_grade
        end
    end

    def edit_grade
    end

    def update_grade
        if @submission.update params.require(:submission).permit(:feedback, :score).merge(course_role_marker_id: current_user.current_course_role.id)
            redirect_to course_course_assignment_submissions_path(@submission.course, @submission.course_assignment)
        else
            render :edit_grade
        end
    end

    def destroy_grade
        @submission.update(feedback: nil, score: nil, course_role_marker_id: nil)
        redirect_to course_course_assignment_submissions_path(@submission.course, @submission.course_assignment)
    end

    private
    def find_submission
        @submission = Submission.find_by(id: params[:id])
        @submission = Submission.find(params[:submission_id]) unless @submission
    end

end
