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
      #
      #   # expect(flash).to include("STUFF")
      # end ### NOTE: NEED TO LOOK UP HOW TO TEST!!! (NO INTERNET)
    end
  end

  describe "#search" do
    before :each do
      get :search
    end

    it "is successful" do
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it "renders the search page" do
      expect(response).to render_template :search
    end

    it "assigns 'result' to nil if no search has occurred" do
      expect(assigns(:results)).to eq nil
    end

    context "successful search" do
      it "assigns 'result' to user info" do
        expect(assigns(:result)).to eq "SOMETHING"
      end
    end

    context "successful search" do
      it "assigns 'result' to empty array if no results found" do
        expect(assigns(:result)).to eq []
      end
    end
  end
end
