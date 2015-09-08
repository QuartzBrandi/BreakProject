require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "#new" do
    it "creates a new session" do
      post :new
      expect(session[:player_id]).to eq 1
    end
  end

  describe "#destroy" do
    it "destories an existing session" do
      delete :destroy
      expect(session[:player_id]).to eq nil
    end
  end
end
