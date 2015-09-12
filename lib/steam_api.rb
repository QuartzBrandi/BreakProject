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

    return game_population || nil
  end

  # GET http://api.steampowered.com/ISteamUser/ResolveVanityURL/v0001/?key=XXXXXXXXXXXXXXXXXXXXXXX&vanityurl=userVanityUrlName
  # { "response": { "steamid": XXXXXXXXXXXXXXXXX, "success": 1 } }
  # { "response": { "success": 42, "message": "No match" } }
  def self.get_steamid(username)
    url = URI + "ISteamUser/ResolveVanityURL/v0001/?key=" +
          ENV["STEAM_WEB_API_KEY"] + "&vanityurl=" + username
    response = HTTParty.get(url)
    steamid = response.parsed_response["response"]["steamid"]

    return steamid || nil
  end

  # GET http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=XXXXXXXXXXXXXXXXXXXXXXX&steamids=userSteamNumberID
  def self.get_player_summary(steamid)
    url = URI + "ISteamUser/GetPlayerSummaries/v0002/?key=" +
          ENV["STEAM_WEB_API_KEY"] + "&steamids=" + steamid
    response = HTTParty.get(url)
    player = response.parsed_response["response"]["players"].first

    if player
      steamid = player["steamid"]
      personaname = player["personaname"]
      avatar_medium = player["avatarmedium"]
      avatar_full = player["avatarfull"]

      player_reformatted = {
        steamid: steamid,
        name: personaname,
        avatar: avatar_medium
      }

      return player_reformatted
    else
      return nil
    end
  end

  # GET http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=XXXXXXXXXXXXXXXXXXXXXXX&steamid=userSteamNumberID&include_appinfo=1&include_played_free_games=1
  # For the optional fields, 1 is for true.
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
        img_logo_url: game["img_logo_url"],
        playtime_total: game["playtime_forever"]
      }
    end

    return games_reformatted
  end
end
