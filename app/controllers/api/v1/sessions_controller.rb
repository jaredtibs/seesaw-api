class Api::V1::SessionsController < Api::V1::BaseController
  before_action :authenticate_user!, except: :create

  def create
    byebug
    @current_user = User.find_by email: params[:username]

    if @current_user and @current_user.valid_password?(params[:password])
      token = UserService.generate_token_for @current_user
      sign_in @current_user
      render json: {token: token, user: JSONAPI::Serializer.serialize(@current_user)}, status: :created
    else
      unauthorized
    end
  end

  def show
    render json: JSONAPI::Serializer.serialize(current_user), status: :ok
  end

end
