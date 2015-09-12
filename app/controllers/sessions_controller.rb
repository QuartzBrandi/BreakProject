class SessionsController < ApplicationController
  def create
    player = Player.create(params_player)
    session[:player_id] = player.id

    games = SteamAPI.get_player_library(player.steamid)
    games.each do |game_info|
      playtime = Playtime.create(playtime_total: game_info[:playtime_total])
      game = Game.find_by(appid: game_info[:appid]) || create_game(game_info)
      playtime.game = game
      playtime.player = player
      player.games << game
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
