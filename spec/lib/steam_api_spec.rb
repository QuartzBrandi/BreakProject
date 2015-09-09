require 'rails_helper'

RSpec.describe SteamAPI do
  describe "#some method" do
    it "returns something" do
      result = SteamAPI.some_method("fish")
      expect(result).to eq "hsif"
    end
  end
end
