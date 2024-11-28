# app/controllers/api/sessions_controller.rb
class Api::SessionsController < Devise::SessionsController
    respond_to :json
  
    def create
      super do |resource|
        render json: { user: resource, message: "Signed in successfully" }, status: :ok and return
      end
    end
  
    def destroy
      super do
        render json: { message: "Signed out successfully" }, status: :ok and return
      end
    end
  end
  