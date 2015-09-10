require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "#create" do
    before :each do
      user = create(:player)
      post :create
    end

    it "creates a new session" do
      expect(session[:player_id]).to eq 1
    end

    it "redirects to the home page" do
      expect(response).to redirect_to url_for(controller: :home, action: :index)
    end
  end

  describe "#destroy" do
    before :each do
      user = create(:player)
      session[:player_id] = user.id
      post :destroy
    end

    it "destories an existing session" do
      expect(session[:player_id]).to eq nil
    end

    it "redirects to the home page" do
      expect(response).to redirect_to url_for(controller: :home, action: :index)
    end
  end
end
