require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  describe "GET index" do
    it "has a 200 status code" do
      get :new
      expect(response.status).to eq(200)
    end
  end
end