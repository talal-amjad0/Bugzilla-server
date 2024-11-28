class Api::RegistrationsController < Devise::RegistrationsController
    def create
      super
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
  