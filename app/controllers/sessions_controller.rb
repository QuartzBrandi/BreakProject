class SessionsController < ApplicationController
  def create
    player = Player.create(params_player)
    session[:player_id] = player.id

    games = SteamAPI.get_player_library(player.steamid)
    games.each do |game|
      record = Playtime.create(playtime_total: game[:playtime_total])
      record.game = Game.create(game)
      record.player = player
    end

    # Updating player's library once a day.
    # Saves the game to the database if
    player = Player.find(session[:player_id])
    if player.updated_at < Time.now - 86400
      games = SteamAPI.get_player_library(player.steamid)
      games.each do |game|
        unless Game.find_by(appid: game[:appid])
          player.games << Game.create(game)
        end
      end
      player.update(updated_at: Time.now)
    end

    # checks once every hour?
    player.games.each do |game|
      if game.updated_at < Time.now - 3600 # 1hr
        population = SteamAPI.get_game_population(game.appid)
        game.population = population
      end
    end

    redirect_to root_path
  end

  def destroy
    reset_session

    redirect_to root_path
  end

  private

  def params_player
    params.require(:player).permit(:steamid, :name, :avatar)
  end
end
