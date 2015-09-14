require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "#index" do

    it "is successful" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it "renders the index page" do
      get :index
      expect(response).to render_template :index
    end

    context "with no session" do
      it "assigns 'library' to nil (does not assign 'library')" do
        get :index
        expect(assigns(:library)).to eq nil
      end

      it "assigns 'player' to nil (does not assign 'player')" do
        get :index
        expect(assigns(:player)).to eq nil
      end
    end

    context "with a session" do
      before :each do
        @user = create(:player)
        session[:player_id] = @user.id
      end

      it "assigns 'library' to player's games" do
        @game = create(:game)
        @user.games << @game
        get :index

        expect(assigns(:library)).to eq [@game]
        expect(assigns(:library)).to eq @user.games
        expect(assigns(:library).count).to eq 1
      end

      it "assigns 'library' to empty array if no games" do
        get :index
        expect(assigns(:library)).to eq []
      end

      it "assigns 'player' to the player matching the current session[:player_id]" do
        get :index
        expect(assigns(:player)).to eq Player.find(session[:player_id])
      end

      it "destroys session & doesn't assign 'player' if no 'player' in the database" do
        Player.destroy(@user.id)
        get :index

        expect(assigns(:player)).to eq nil
        expect(session[:player_id]).to eq nil
      end

      # it "throws a flash error if no 'player' in the database" do
      #   Player.destroy(@user.id)
      #   get :index
      #   # expect(flash).to include("STUFF")
      # end ### NOTE: NEED TO LOOK UP HOW TO TEST!!! (NO INTERNET)
    end
  end

  describe "#search" do
    it "is successful" do
      get :search
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it "renders the search page" do
      get :search
      expect(response).to render_template :search
    end

    it "assigns 'player' to nil if no search has occurred" do
      get :search
      expect(assigns(:player)).to eq nil
    end

    context "successful search" do
      it "assigns 'player' to user info (via vanity_url)" do
        VCR.use_cassette('successful vanity_url') do
          get :search, { id: "linkgirl", type: "vanity_url" }
          player = build(:player, steamid: "76561198007153084", name: "Muselord", avatar: "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/8e/8e9805a58f9ede070e49ac2ed92385089f11032f_medium.jpg")
          expect(assigns(:player).name).to eq "Muselord"
          expect(assigns(:player).steamid).to eq "76561198007153084"
        end
      end ### NOTE: This threw and error when trying to compare :player to player. I'm assuming because they are different objects even though all the values are the same. WHY is this???

      it "assigns 'player' to user info (via steamid)" do
        VCR.use_cassette('successful steamid') do
          get :search, { id: "76561198007153084", type: "steamid" }
          player = build(:player, steamid: "76561198007153084", name: "Muselord", avatar: "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/8e/8e9805a58f9ede070e49ac2ed92385089f11032f_medium.jpg")
          expect(assigns(:player).name).to eq "Muselord"
          expect(assigns(:player).steamid).to eq "76561198007153084"        end
      end
    end ### NOTE: This threw and error when trying to compare :player to player. I'm assuming because they are different objects even though all the values are the same. WHY is this???
        ### ORIGINAL CODE: expect(assigns(:player)).to eq player

    context "unsuccessful search" do
      it "assigns 'player' to empty array if no results found (via vanity_url)" do
        VCR.use_cassette('unsuccessful vanity_url') do
          get :search, { id: "@$%NOTVALID00", type: "vanity_url" }
          expect(assigns(:player)).to eq []
        end
      end

      it "assigns 'player' to empty array if no results found (via steamid)" do
        VCR.use_cassette('unsuccessful steamid') do
          get :search, { id: "linkgirl", type: "steamid" }
          expect(assigns(:player)).to eq []
        end
      end
    end
  end
end

### NOTE: CHECK VCR SPECS!!
