require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "#index" do
    before :each do
      get :index
    end

    it "is successful" do
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it "renders the index page" do
      expect(response).to render_template :index
    end

    context "with no session" do
      it "assigns 'library' to nil" do
        expect(assigns(:library)).to eq nil
      end
    end

    context "with a session" do
      before :each do
        session[:player_id] = "NOT DETEREMINED YET"
      end

      it "assigns 'library' to player's games" do
        expect(assigns(:library)).to eq ["RESULTS"]
      end

      it "assigns 'library' to empty array if no games" do
        expect(assigns(:library)).to eq []
      end
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
  end
end
