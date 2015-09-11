require 'rails_helper'

RSpec.describe SteamAPI do
  describe "#get_game_population" do
    it "takes a string (appid) and an argument" do

    end

    it "returns an integer" do

    end

    it "returns -1 if not a game on Steam" do

    end
  end

  describe "#get_steamid" do
    it "takes a string (username) as an argument" do

    end

    it "returns a string (of numbers)" do

    end

    it "returns '-1' if not a valid Steam username" do

    end
  end

  describe "#get_player_summary" do
    it "takes a string (Steam ID) as an argument" do

    end

    it "returns stuff" do

    end
  end

  describe "#get_player_library" do
    it "takes a string (Steam ID) as an argument" do

    end

    it "returns a hash of games (appid: {name, img_logo_url})" do
      # appid + name + img_logo_url
      # {440: {name: 'Team Fortress 2', img_logo_url: 'img'}}

    end

    it "returns an empty hash if user is private" do

    end

    it "returns an empty hash if user owns no games" do

    end
  end
end
