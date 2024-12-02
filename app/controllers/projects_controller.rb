class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show update destroy ]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /projects
  def index
    @projects = Project.all

    render json: @projects
  end

  # GET /projects/1
  def show
    render json: @project
  end

  # POST /projects
  def create
    request_body = JSON.parse(request.body.read)
    @project = Project.new(request_body)
    @project.manager = current_user

    if @project.save
      render json: { message: 'Project created successfully', project: @project }, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # /PUT /projects/1
  def update
    request_body = JSON.parse(request.body.read)
    if @project.update(request_body)
      render json: { message: 'Project updated successfully', project: @project }, status: :ok
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  def destroy
    @project = Project.find_by(id: params[:id])

    if @project
      @project.destroy
      render json: {message: 'Project deleted Successfully'}, status: :ok
    else
      render json: {message: 'Project not found'}, status: :not_found
    end

  rescue StandardError => e
    render json: {error: e.message}, status: :internal_server_error
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:title, :description)
    end
end
