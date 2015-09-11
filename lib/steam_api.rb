class SteamAPI
  URI = "http://api.steampowered.com/"

  # GET http://api.steampowered.com/ISteamUserStats/GetNumberOfCurrentPlayers/v0001/?appid=gameApplicationID&format=jsonOrXML
  # { "response": { "player_count": X, "result": 1 } }
  # { "response": { "result": 42 } }
  def self.get_game_population(appid)
    url = URI + "ISteamUserStats/GetNumberOfCurrentPlayers/v0001/?appid=" +
          appid.to_s
    response = HTTParty.get(url)
    game_population = response.parsed_response["response"]["player_count"]

    return game_population || false
  end

  # GET http://api.steampowered.com/ISteamUser/ResolveVanityURL/v0001/?key=XXXXXXXXXXXXXXXXXXXXXXX&vanityurl=userVanityUrlName
  # { "response": { "steamid": XXXXXXXXXXXXXXXXX, "success": 1 } }
  # { "response": { "success": 42, "message": "No match" } }
  def self.get_steamid(username)
    url = URI + "ISteamUser/ResolveVanityURL/v0001/?key=" +
          ENV["STEAM_WEB_API_KEY"] + "&vanityurl=" + username
    response = HTTParty.get(url)
    steamid = response.parsed_response["response"]["steamid"]

    return steamid || false
  end

  # GET http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=XXXXXXXXXXXXXXXXXXXXXXX&steamids=userSteamNumberID
  def self.get_player_summary(steamid)
    url = URI + "ISteamUser/GetPlayerSummaries/v0002/?key=" +
          ENV["STEAM_WEB_API_KEY"] + "&steamids=" + steamid
    response = HTTParty.get(url)
    player = response.parsed_response["response"]["players"].first
    steamid = player["steamid"]
    personaname = player["personaname"]
    avatar_medium = player["avatarmedium"]
    avatar_full = player["avatarfull"]

    player_reformatted = {
      steamid: steamid,
      name: personaname,
      avatar: avatar_full
    }

    return player_reformatted
  end

  # GET http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=XXXXXXXXXXXXXXXXXXXXXXX&steamid=userSteamNumberID&include_appinfo=1&include_played_free_games=1
  # 1 is for true, not sure what number is used for false (most of the optional filters are false by default)
  # { "response":
  #   { "game_count": X,
  #     "games": [
  #       { "appid": XXXXX,
  #         "name": X,
  #         "playtime_forever": XX,
  #         "img_icon_url": X,
  #         "img_logo_url": X,
  #         "has_community_visible_stats": X }
  #     ]
  #   }
  # }
  def self.get_player_library(steamid)
    url = URI + "IPlayerService/GetOwnedGames/v0001/?key=" +
          ENV["STEAM_WEB_API_KEY"] + "&steamid=" + steamid +
          "&include_appinfo=1&include_played_free_games=1"
    response = HTTParty.get(url)
    games = response["response"]["games"]

    games_reformatted = []
    games.each do |game|
      games_reformatted << {
        appid: game["appid"],
        name: game["name"],
        playtime_total: game["playtime_forever"],
        img_logo_url: game["img_logo_url"]
      }
    end

    return games_reformatted
  end
end
