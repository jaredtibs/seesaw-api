class Api::V1::LocationsController < Api::V1::BaseController
  before_action :authenticate_user!, except: :create

end
