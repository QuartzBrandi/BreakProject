class SessionsController < ApplicationController
  def create
    if Player.find_by(steamid: params[:player][:steamid])
      player = Player.find_by(steamid: params[:player][:steamid])
      session[:player_id] = player.id
    else
      player = Player.create(params_player)
      session[:player_id] = player.id

      games = SteamAPI.get_player_library(player.steamid)
      games.each do |game_info|
        playtime = Playtime.new(playtime_total: game_info[:playtime_total])
        game = Game.find_by(appid: game_info[:appid]) || create_game(game_info)
        playtime.game = game
        playtime.player = player
        playtime.save
      end
    end

    redirect_to root_path
  end

  def destroy
    # # DESTROY AFTER A DAY? INSTEAD -- OR 30 DAYS LATER?
    # # WOULD NEED TO SEARCH FOR IT INSTEAD OF CREATING EACH TIME THEN
    # player = Player.find(session[:player_id])
    # player.destroy
    reset_session

    redirect_to root_path
  end

  private

  def params_player
    params.require(:player).permit(:steamid, :name, :avatar)
  end
end
