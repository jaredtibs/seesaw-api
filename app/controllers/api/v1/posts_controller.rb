class Api::V1::PostsController < Api::V1::BaseController
  before_action :authenticate_user!

  def create
    #params[:location_id]
    # create a post for a user and location
  end

  def feed

  end

end
