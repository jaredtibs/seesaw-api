class Api::V1::PostsController < Api::V1::BaseController
  before_action :authenticate_user!
end
