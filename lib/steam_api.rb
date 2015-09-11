class SteamAPI
  URI = "http://api.steampowered.com/"

  # GET http://api.steampowered.com/ISteamUserStats/GetNumberOfCurrentPlayers/v0001/?appid=gameApplicationID&format=jsonOrXML
  def self.get_game_population(appid)
    url = URI + "ISteamUserStats/GetNumberOfCurrentPlayers/v0001/?appid=" +
          appid
    response = HTTParty.get(url)
    # { "response": { "player_count": XXXX, "result": 1 } }
    # { "response": { "result": 42 } }
    player_count = response.parsed_response["response"]["player_count"]

    return player_count
  end

  # GET http://api.steampowered.com/ISteamUser/ResolveVanityURL/v0001/?key=XXXXXXXXXXXXXXXXXXXXXXX&vanityurl=userVanityUrlName
  def self.get_steam_ID(username)
    url = URI + "ISteamUser/ResolveVanityURL/v0001/?key=" +
          ENV["STEAM_WEB_API_KEY"] + "&vanityurl=" + username
    response = HTTParty.get(url)
    # { "response": { "steamid": "XXXXXXXXXXXXXXXXX", "success": 1 } }
    # { "response": { "success": 42, "message": "No match" } }
    success = response.parsed_response["response"]["success"]
    steamid = response.parsed_response["response"]["steamid"]
    message = response.parsed_response["response"]["message"]

    return success == 1 ? steamid : false
  end

  # GET http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=XXXXXXXXXXXXXXXXXXXXXXX&steamids=userSteamNumberID
  def self.get_player_summary(steam_ID)
    url = URI + "ISteamUser/GetPlayerSummaries/v0002/?key=" +
          ENV["STEAM_WEB_API_KEY"] + "&steamids=" + steam_ID
    response = HTTParty.get(url)

    player = response.parsed_response["response"]["players"].first
    personaname = player["personaname"]
    avatar = player["avatar"]
    avatar_medium = player["avatarmedium"]
    avatar_full = player["avatarfull"]
    player_reformatted = { personaname: personaname, avatar: avatar }

    return player_reformatted
  end

  # GET http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=XXXXXXXXXXXXXXXXXXXXXXX&steamid=userSteamNumberID&include_appinfo=1&include_played_free_games=1
    # 1 is for true, not sure what number is used for false (most of the optional filters are false by default)
  def self.get_player_library(steam_ID)
    url = URI + "IPlayerService/GetOwnedGames/v0001/?key=" +
          ENV["STEAM_WEB_API_KEY"] + "&steamid=" + steam_ID +
          "&include_appinfo=1&include_played_free_games=1"
    response = HTTParty.get(url)
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
    games = response["response"]["games"]
    # maybe only get ones with a playtime_forever > 0?
    games_reformatted = {}
    games.each do |game|
      games_reformatted[game["appid"]] = {
        name: game["name"],
        img_logo_url: game["img_logo_url"]
      }
    end

    return games_reformatted
  end
end
