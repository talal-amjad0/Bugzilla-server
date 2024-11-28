class BugsController < ApplicationController
    before_action :set_bug, only: [:show, :update, :destroy]
  
    
    def index
      @bugs = Bug.all
      render json: @bugs
    end
  
    
    def show
      render json: @bug
    end
  
    
    def create
      bug_data = JSON.parse(request.body.read)
  
      @bug = Bug.new(bug_data)
  
      if @bug.save
        render json: @bug, status: :created, location: @bug
      else
        render json: @bug.errors, status: :unprocessable_entity
      end
    end
  
    def update
      bug_data = JSON.parse(request.body.read)
  
      if @bug.update(bug_data)
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
  end
  