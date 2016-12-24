class WelcomeController < ApplicationController

  def index
    render json: {api_active: true}
  end
end
