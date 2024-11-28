class Api::RegistrationsController < Devise::RegistrationsController
    def create
        super do |resource|
          # After the user is created, sign them in automatically
          sign_in(resource)  # Automatically sign in after registration
          render json: { user: resource, message: "Account created and signed in successfully" }, status: :created and return
        end
      rescue StandardError => e
        # Handle any registration errors (e.g., validation errors)
        render json: { error: e.message }, status: :unprocessable_entity
      end
  end
  