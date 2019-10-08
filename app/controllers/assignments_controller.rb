class AssignmentsController < ApplicationController
  before_action :find_assignment, only: [:show, :edit, :update, :destroy]

  def index
    @assignments = Assignment.all
  end

  def new
    @assignment = Assignment.new
  end

  def create
    @assignment = Assignment.new assignment_params

    if @assignment.save
      redirect_to assignment_path(@assignment)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @assignment.update assignment_params
      redirect_to assignment_path(@assignment)
    else
      render :edit
    end
  end

  def destroy
    @assignment.destroy
    redirect_to assignments_path
  end

  private

  def assignment_params
    params.require(:assignment).permit(:name, :description)
  end

  def find_assignment
    @assignment = Assignment.find params[:id]
  end
end
