class ProjectUsersController < ApplicationController
    before_action :set_project_user, only: [:update]
    before_action :authenticate_user!
  
    def create
      request_body = JSON.parse(request.body.read)
  
      project = Project.find(params[:project_id]) 
      user = User.find(request_body['user_id']) 
  
      if project.users.include?(user)
        render json: { message: 'User is already assigned to this project' }, status: :unprocessable_entity
      else
        # Assign the user to the project
        project.users << user
        render json: { message: 'User added to the project successfully' }, status: :created
      end
    end
  
    def destroy
        project = Project.find(params[:project_id]) 
        user = User.find(params[:id])  
      
        project_user = ProjectUser.find_by(project_id: project.id, user_id: user.id)
      
        if project_user
          project_user.destroy
          render json: { message: 'User removed from the project' }, status: :ok
        else
          render json: { message: 'User not found in the project' }, status: :not_found
        end
      end
      
  
    # GET /projects/:project_id/project_users
    def index
      project = Project.find(params[:project_id]) 
      users = project.users                        
      render json: users
    end
  
    def update
      request_body = JSON.parse(request.body.read)
  
      if @project_user.update(project_user_params(request_body))
        render json: @project_user
      else
        render json: @project_user.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_project_user
      @project_user = ProjectUser.find(params[:id])
    end
  
    def project_user_params(request_body)
      {
        user_id: request_body['user_id'],
        project_id: request_body['project_id']
      }
    end
  end
  