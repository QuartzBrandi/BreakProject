require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "#index" do
    it "is successful" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq 200
      expect(response).to have_http_status 200
    end

    it "renders the index page" do
      get :index
      expect(response).to render_template :index
    end

    context "with no session" do
      it "assigns 'library' to an empty array" do
        get :index
        expect(assigns(:library)).to eq nil
      end
    end

    context "with a session" do
      it "assigns 'library' to player's games" do
        get :index
        expect(assigns(:library)).to eq ["RESULTS"]
      end
    end
  end
end
