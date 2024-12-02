class BugsController < ApplicationController
  before_action :set_bug, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    project = Project.find(params[:project_id])
    @bugs = project.bugs
    render json: @bugs
  end
  

  def show
    render json: @bug
  end

  def create
    # Automatically set created_by_id to the currently logged-in user
    bug_data = bug_params
    bug_data[:created_by_id] = current_user.id 

    # Check if assignee is a developer
    assignee = User.find(bug_data[:assignee_id])
    unless assignee.developer?
      render json: { message: 'Assignee must be a developer' }, status: :unprocessable_entity
      return
    end

    @bug = Bug.new(bug_data)

    if @bug.save
      render json: @bug, status: :created
    else
      render json: @bug.errors, status: :unprocessable_entity
    end
  end

  def update
    assignee = User.find(bug_params[:assignee_id])
    unless assignee.developer?
      render json: { message: 'Assignee must be a developer' }, status: :unprocessable_entity
      return
    end

    if @bug.update(bug_params)
      render json: @bug
    else
      render json: @bug.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @bug.destroy
    head :no_content
  end

  private

  def set_bug
    @bug = Bug.find(params[:id])
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :bug_type, :status, :assignee_id, :project_id)
  end
end
