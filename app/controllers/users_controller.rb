class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      # session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end

  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def password
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update user_params
      redirect_to root_path
      flash[:notice] = 'User information updated'
    else
      render :edit
    end
  end

  def update_password
    @user = User.find(params[:id])
    if @user.authenticate(params[:current_password]) && params[:password] == params[:password_confirmation]
      if @user.update password: params[:password]
          redirect_to :root
      else
          redirect_to password_path(@user)
      end
    else
      redirect_to password_path
    end
  end

  def destroy
    flash[:notice] = "User deleted"
    @user.destroy
    redirect_to root_path

  end
  
  def courses
    @user = User.find(params[:id])
    @active_courses = @user.active_courses
    @archived_courses = @user.archived_courses
  end
    
  def due_assignments
    # For students only
    @assignments = current_user.current_course_role.course.course_assignments.pending
  end

  def submitted_assignments
    # For instructors only
    @assignments = current_user.course_roles.where(role: "instructor").map(&:course).map { |course|
      course.course_assignments.select { |ca|
        ca.submissions.inject(false) { |acc, submission|
          submission.course_role_marker_id.nil? && !acc ? true : acc
          }
        }
      }.flatten
  end

  end

  def new_role
    @user = User.find(params[:id])
    @role = CourseRole.new
    @courses = Course.all
  end

  def create_role
    @user = User.find(params[:id])

    CourseRole.create(
      user: @user,
      role: params[:course_role][:role],
      course_id: params[:course_role][:course_id],
      is_archived: false
    )

    redirect_to @user
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :status, :img_url, :is_admin)
  end




end
