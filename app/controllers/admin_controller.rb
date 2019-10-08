class AdminController < ApplicationController

    def courses
        @courses = Course.all
    end

    def users
        @users = User.all
    end

    def archive
        @archive = {
            courses: Course.where(is_archived: true),
            course_roles: CourseRole.where(is_archived: true)
        }
    end

end
