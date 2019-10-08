class ApplicationController < ActionController::Base

    before_action :authenticate_user!

    def current_user
        User.find_by(id: session[:user_id])
    end
    
    helper_method :current_user
    
    def admin_signed_in?
        current_user&.is_admin?
    end

    helper_method :admin_signed_in?

    def user_signed_in?
        !current_user.nil?
    end

    helper_method :user_signed_in?

    def is_marked?(course_assignment = nil, submission: nil)
        if submission
            !submission.course_role_marker_id.nil?
        else
            course_assignment.submissions.find_by(course_role_submitter_id: current_user.id).present?
        end
    end

    helper_method :is_marked?

    def get_host_without_www(url)
        uri = URI.parse(url)
        uri = URI.parse("http://#{url}") if uri.scheme.nil?
        host = uri.host.downcase
        host.start_with?('www.') ? host[4..-1] : host
    end

    helper_method :get_host_without_www

    def find_submission(course_role, course_assignment)
        Submission.find_by(
            course_role_submitter_id: course_role.id,
            course_assignment_id: course_assignment.id
        )
    end

    helper_method :find_submission

    private
    def authenticate_user!
        redirect_to "/login" unless user_signed_in? || ["/login", "/sign_up", "/sessions/new", "/sessions"].include?(request.path) 
    end
end
