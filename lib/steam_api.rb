class SteamAPI
  URI = "http://api.steampowered.com/"

  # GET http://api.steampowered.com/ISteamUserStats/GetNumberOfCurrentPlayers/v0001/?appid=gameApplicationID&format=jsonOrXML
  def self.get_game_population(appid)
    url = URI + "ISteamUserStats/GetNumberOfCurrentPlayers/v0001/?appid=" +
          appid
  end

  # GET http://api.steampowered.com/ISteamUser/ResolveVanityURL/v0001/?key=XXXXXXXXXXXXXXXXXXXXXXX&vanityurl=userVanityUrlName
  def self.get_steam_ID(username)
    url = URI + "ISteamUser/ResolveVanityURL/v0001/?key=" +
          ENV["STEAM_WEB_API_KEY"] + "&vanityurl=" + username
    response = HTTParty.get(url)
    raise
    response.parsed_response["response"]["success"] == 1 || 42
    response.parsed_response["response"]["message"]
    response.parsed_response["response"]["steamid"]
  end

  # GET http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=XXXXXXXXXXXXXXXXXXXXXXX&steamids=userSteamNumberID
  def self.get_player_summary(steam_ID)
    url = URI + "ISteamUser/GetPlayerSummaries/v0002/?key=" +
          ENV["STEAM_WEB_API_KEY"] + "&steamid=" + steam_ID

    # "communityvisibilitystate = 1" means private
    # "communityvisibilitystate = 3" means public
  end

  # GET http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=XXXXXXXXXXXXXXXXXXXXXXX&steamid=userSteamNumberID&include_appinfo=1&include_played_free_games=1
    # 1 is for true, not sure what number is used for false (most of the optional filters are false by default)
  def self.get_player_library(steam_ID)
    url = URI + "IPlayerService/GetOwnedGames/v0001/?key=" +
          ENV["STEAM_WEB_API_KEY"] + "&steamid=" + steam_ID +
          "&include_appinfo=1&include_played_free_games=1"
  end
end
