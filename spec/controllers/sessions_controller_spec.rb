require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "#create" do
    context "if player is already in the database" do
      before :each do
        @user = create(:player, steamid: "76561198007153084")
        post :create, { player: { steamid: "76561198007153084" } }
      end

      it "creates a new session" do
        expect(session[:player_id]).to eq @user.id
      end

      it "redirects to the home page" do
        expect(response).to redirect_to root_path
      end
    end

    context "if player is not already in the database" do
      before :each do
        VCR.use_cassette('create session') do
          post :create, { player: { steamid: "76561198007153084" } }
        end
      end

      it "creates a new session" do
        expect(session[:player_id]).to eq Player.first
      end

      it "redirects to the home page" do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "#destroy" do
    ### NOTE: How exactly DO you test a destroy action for the sessions controller?
    ### It's not like you need to pass an id to destroy the session...
    before :each do
      user = create(:player)
      session[:player_id] = user.id
      delete :destroy, id: session[:player_id]
    end

    it "destories an existing session" do
      expect(session[:player_id]).to eq nil
    end

    it "redirects to the home page" do
      expect(response).to redirect_to root_path
    end
  end
end
