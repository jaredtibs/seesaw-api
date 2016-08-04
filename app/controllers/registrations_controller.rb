class RegistrationsController < ApplicationController

  def create
    user = User.new registration_params
    if user.save
      token = User.create_token_for(user)
      sign_in user
      render json: { token: token }, status: created
    else
      render json: { errors: user.errors.full_messages },
        status: :unprocessable_entity
    end
  end

  private

  def registration_params
    params.require(:email)
    params.require(:password)
    params.permit(:email, :password, :username)
  end
end
