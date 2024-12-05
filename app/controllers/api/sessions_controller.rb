# app/controllers/api/sessions_controller.rb
class Api::SessionsController < Devise::SessionsController
    respond_to :json
  
    def create
        sign_out(current_user) if current_user
    
        super do |resource|
          sign_in(resource)
          response.set_header('Access-Control-Allow-Credentials', 'true')
          render json: { user: resource, message: "Signed in successfully" }, status: :ok and return
        end
      end
  
    def destroy
      super do
        sign_out(current_user) 
        render json: { message: "Signed out successfully" }, status: :ok and return
      end
    end
  end
  