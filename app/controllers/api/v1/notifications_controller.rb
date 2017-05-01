class Api::V1::NotificationsController < Api::V1::BaseController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notications
    @notifications.update_all checked: true

    render json: @notifications,
      meta: {count @notifications.count},
      each_serializer: NotificationSerializer,
      scope: current_user,
      scope_name: :current_user,
      status: :ok
  end
end
