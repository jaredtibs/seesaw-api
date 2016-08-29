require 'rails_helper'

RSpec.describe Api::V1::RegistrationsController do

  context "success" do
    it "should register a new user" do
      post 'create', email: 'test@email.com', password: 'password', username: "user1"
      expect(response.status).to eq(201)
      body = JSON.parse(response.body)
      expect(body).to have_key("token")
    end
  end

  context "failure" do
    before do
      FactoryGirl.create :user, email: "taken-email@gmail.com", username: 'takenusername'
    end

    it "should not register a user if the email is taken" do
      post 'create', email: 'taken-email@gmail.com', password: 'password', username: "user1"
      expect(response.status).to eq(422)
      body = JSON.parse(response.body)
      expect(body).to_not have_key("token")
      expect(body["errors"][0]).to eq "Email has already been taken"
    end

    it "should not register a user if the username is taken" do
      post 'create', email: 'new-email@gmail.com', password: 'password', username: "takenusername"
      expect(response.status).to eq(422)
      body = JSON.parse(response.body)
      expect(body).to_not have_key("token")
      expect(body["errors"][0]).to eq "Username has already been taken"
    end

    it "should not register a user if the username is blank" do
      post 'create', email: 'new-email@gmail.com', password: 'password'
      expect(response.status).to eq(422)
      body = JSON.parse(response.body)
      expect(body).to_not have_key("token")
      expect(body["errors"][0]).to eq "Username can't be blank"
    end
  end
end
