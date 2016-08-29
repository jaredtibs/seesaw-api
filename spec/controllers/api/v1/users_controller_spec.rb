require 'rails_helper'

RSpec.describe Api::V1::UsersController do
  let (:user) { FactoryGirl.create :user }
  let (:other_user) { FactoryGirl.create(:user, username: 'jmtibs') }

  before do
    sign_in user
  end

  describe "GET #show" do
    it "returns the requested user" do
      get "show", username: other_user.username
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body["data"]["id"].to_i).to eq(other_user.id)
    end
  end

end
