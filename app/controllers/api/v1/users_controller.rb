class Api::V1::UsersController < Api::V1::BaseController
  before_action :authenticate_user!, only: [
    :show,
    :index,
    :search,
    :update,
    :update_email,
    :update_avatar
  ]

  before_action :find_user_by_name, only: [:show]

  def show
    if @user
      render json: @user, serializer: UserSerializer, status: :ok
    else
      not_found
    end
  end

  # used as "top users" placeholder in search
  def index
    @users = User.order('created_at desc').first(10)
    render json: @users,
      meta: { count: @users.count },
      each_serializer: UserSerializer,
      status: :ok
  end

  def search
    query = params[:query] || nil
    users = User.where('username ILIKE ?', "#{query}%") if query
    result = users || []
    render json: result,
      meta: { count: result.count },
      each_serializer: UserSerializer,
      status: :ok
  end

  def update
    if current_user.update update_params
      render json: { success:  I18n.t('success.users.account_updated')}, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def reset_password
    @user = User.find_by email: params[:email]

    if @user
      token = UserService.send_reset_password_instructions @user
      #TODO send reset password instructions email
      render json: { success: I18n.t('success.users.reset_password_sent')}, status: :ok
    else
      render json: { errors: I18n.t('errors.user_not_found') }, status: :unprocessable_entity
    end
  end

  def update_password
    pass_token = Devise.token_generator.digest(
      User, :reset_password_token,
      update_password_params[:reset_password_token]
    )
    user = User.find_by reset_password_token: pass_token

    if user
      outcome = UserService.update_password(user, update_password_params)
      if outcome[:result] == "success"
        sign_in user
        render json: {token: outcome[:result][:token]}, status: :ok
      else
        render json: {errors: outcome[:result][:errors]}, status: :unprocessable_entity
      end
    else
      unauthorized
    end
  end

  def update_email
    password = update_email_params[:password]
    email = update_email_params[:email]

    if current_user.valid_password?(password)
      current_user.email = email
      if current_user.save
        render json: { success: "email updated" }, status: :ok
      else
        render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: "invalid password" }, status: :forbidden
    end
  end

  def update_avatar
    current_user.image_data = avatar_params[:file]
    if current_user.save
      render json: current_user, serializer: UserSerializer, status: :ok
    else
      render json: {errors: "error updating avatar"}, status: :unprocessable_entity
    end
  end

  private

  def find_user_by_name
    @user = User.find_by username: params[:username]
  end

  def update_params
    params.permit(:username)
  end

  def reset_password_params
    params.require(:email)
    params.permit(:email)
  end

  def update_password_params
    params.require(
      :reset_password_token
    )
    params.permit(
      :user,
      :reset_password_token,
      :password,
      :password_confirmation
    )
  end

  def update_email_params
    params.require(:password, :email)
    params.permit(:password, :email)
  end

  def avatar_params
    params.require(:file)
    params.permit(
      :user,
      :file,
      :avatar_x,
      :avatar_y
    )
  end

end
