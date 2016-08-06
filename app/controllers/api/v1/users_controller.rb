class Api::V1::UsersController < Api::V1::BaseController
  before_action :authenticate_user!, except: :create
  before_action :find_user_by_name, only: [:show]
  before_action :find_user_by_id, only: [:update]

  def show
    if @user
      render json: JSONAPI::Serializer.serialize(@user), status: :ok
    else
      render_not_found
    end
  end

  def index
    @users = User.order('created_at desc')
    render json: JSONAPI::Serializer.serialize(
      @users,
      meta: { count: users.count },
      is_collection: true),
      status: :ok
  end

  def update
    if @user.update update_params
      render json: { success:  'account updated'}, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def reset_password
    @user = User.find_by email: params[:email]
    if @user
      UserService.send_reset_password_instructions @user
      #TODO send reset password instructions email
      render json: { success: t('errors.success.reset_password_sent') }, status: :ok
    else
      render json: { errors: t('errors.user_not_found') }, status: :unprocessable_entity
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
        render json: {'token' => outcome[:result][:token]}, status: :ok
      else
        render json: {errors: outcome[:result][:errors]}, status: :unprocessable_entity
      end
    else
      unauthorized
    end
  end

  #TODO update email endpoint

  private

  def find_user_by_id
    @user = User.find_by id: params[:id]
  end

  def find_user_by_name
    @user = User.find_by username: params[:username]
  end

  def update_params
    params.permit(:slug)
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
      :reset_password_token,
      :password,
      :password_confirmation
    )
  end

  def update_email_params
  end

end
