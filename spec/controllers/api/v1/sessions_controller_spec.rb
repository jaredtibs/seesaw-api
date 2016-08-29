require 'rails_helper'

RSpec.describe Api::V1::SessionsController do
  let (:user) { FactoryGirl.create :user, email: 'test@gmail.com', password: "password" }

  it "signs in a user successfully" do
    post "create", email: user.email, password: user.password
    expect(response.status).to eq(201)
    body = JSON.parse(response.body)
    expect(body).to have_key("token")
  end

end
