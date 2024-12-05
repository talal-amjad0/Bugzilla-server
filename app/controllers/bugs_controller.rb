class BugsController < ApplicationController
  before_action :set_bug, only: [:show, :update, :destroy, :update_bug_status]
  before_action :authenticate_user!
  load_and_authorize_resource


  def get_developers
    project = Project.find(params[:project_id])
    developers = project.users.where(user_type: 'developer')
    render json: developers
  end

  def index
    project = Project.find(params[:project_id])
    @bugs = project.bugs.includes(:created_by, :assignee) 
    render json: @bugs, include: ['created_by', 'assignee']
  end
  

  def show
    render json: @bug
  end

  def create
    bug_data = bug_params
    # bug_data[:created_by_id] = current_user.id 
    bug_data[:created_by_id] = 9

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
  
    if @bug
      @bug.destroy
      render json: { message: 'Bug deleted successfully' }, status: :ok
    else
      render json: { message: 'Bug not found' }, status: :not_found
    end
  
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end


  def update_bug_status
    assignee = @bug.assignee 


    authorize! :update_bug_status, @bug

   
    unless assignee&.developer?
      render json: { message: 'Assignee must be a developer to update bug status' }, status: :unprocessable_entity
      return
    end

    if @bug.update(bug_status_params)
      render json: @bug, status: :ok
    else
      render json: @bug.errors, status: :unprocessable_entity
    end
  end
  

  private

  def set_bug
    @bug = Bug.find(params[:id])
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :bug_type, :bug_status, :assignee_id, :project_id, :deadline,:image)
  end

  def bug_status_params
    params.require(:bug).permit(:bug_status) 
  end
end
