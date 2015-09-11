# Makes the file "autoloaded."
# Used with 'config.watchable_dirs['lib'] = [:rb]' in the application.rb file.
require_dependency "#{Rails.root}/lib/steam_api"

class HomeController < ApplicationController
  def index
    if session[:player_id]
    @player = Player.find(session[:player_id])
    library = SteamAPI.get_player_library(@player.steamid)
    library.each do |game|
      pop = SteamAPI.get_game_population(game[:appid])
      game[:population] = pop
    end
  end

    # @library = @player.games
    @library = library
  end

  def search
    steamid = SteamAPI.get_steamid(params[:id])
    # if steamid returns false / -1 do something
    player = SteamAPI.get_player_summary(steamid) unless steamid == false
    @player = Player.new(player)
  end
end
