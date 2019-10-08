require "csv"

class User < ApplicationRecord
  has_secure_password
  has_many :course_roles, dependent: :destroy\

  def full_name
    "#{first_name} #{last_name}".strip
  end

  def archived_courses
    self.course_roles.map(&:course).select { |course| course.is_archived == true }
  end

  def active_courses
    self.course_roles.map(&:course).select { |course| course.is_archived == false }
  end

  def current_role
    self.is_admin ? "admin" : current_course_role&.role
  end

  def current_course_role
    self.is_admin? ? CourseRole.new(course: Course.all.sample, user: self, role: "admin") : self.course_roles.where(is_archived: false).first
  end

  def self.import_from_CSV(filepath)
    data = CSV.read(filepath, headers: true)
    data.each do |row|

      # Remove excess whitespace
      row.map { |key, value| [key, value ? value.strip : value] }.to_h

      user_data = {
        email: row["email"],
        first_name: row["first_name"],
        last_name: row["last_name"],
        password: row["password"],
        img_url: row["img_url"],
        is_admin: row["role"] == "admin",
        status: row["status"]
      }
      
      user = User.create(user_data)
      
      unless row["role"] == "admin" || !user
        course = nil
        
        # If a number is given, check by id
        # Otherwise try to find it by name
        if row["course"].match(/\d+/)
          course = Course.find_by(id: row["course"])
        else
          course = Course.find_by(name: row["course"])
        end
          
        if course
          CourseRole.create(
            role: row["role"],
            user_id: user.id,
            course_id: course.id,
            is_archived: false
          )
        else
          puts "WARNING USER #{row['email']} WAS NOT CREATED. Check that your course is a valid id or name"
          # Don't create a user without a role
          user.destroy
        end

      end
      
    end
  end

end
