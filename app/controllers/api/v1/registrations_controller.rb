class Api::V1::RegistrationsController < Api::V1::BaseController

  def create
    user = User.new registration_params
    if user.save
      token = UserService.generate_token_for(user)
      sign_in user
      render json: { token: token, user: JSONAPI::Serializer.serialize(user)}, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def registration_params
    params.require(:email)
    params.require(:password)
    params.permit(:email, :password, :username)
  end
end
