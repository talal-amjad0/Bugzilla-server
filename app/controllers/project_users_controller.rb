class ProjectUsersController < ApplicationController
    before_action :set_project_user, only: [:update]
    before_action :authenticate_user!


    def get_available_users
        # Find users who are developers or qa and are not already assigned to any project
        available_users = User
                           .where(user_type: ['developer', 'qa'])  # Filter by role
                           .where.not(id: ProjectUser.pluck(:user_id))  # Exclude users already in any project
    
        render json: available_users
    end
  
    def create
        request_body = JSON.parse(request.body.read)
      
        project = Project.find(params[:project_id])
      
        # Extract the array of user_ids from the request body
        user_ids = request_body['user_ids']
      
        # Find the users by their IDs
        users = User.where(id: user_ids)
      
        # Validate that the users are either 'developer' or 'qa' only
        invalid_users = users.select { |user| !['developer', 'qa'].include?(user.user_type) }
        if invalid_users.any?
          render json: { message: 'The following users have invalid roles (only developer or qa allowed)', 
                         users: invalid_users.map { |user| { id: user.id, role: user.user_type } } },
                 status: :unprocessable_entity
          return
        end
      
        # Check if any user is already part of another project
        users_in_other_projects = users.select { |user| user.projects.exists? }
      
        if users_in_other_projects.any?
          render json: { message: 'The following users are already assigned to other projects', 
                         users: users_in_other_projects.map { |user| { id: user.id, name: user.name } } },
                 status: :unprocessable_entity
          return
        end
      
        # Add the users to the project
        project.users << users
      
        render json: { 
          message: 'Users added to the project successfully',
          users: users.map { |user| { id: user.id, role: user.role } }
        }, status: :created
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
  