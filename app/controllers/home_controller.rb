# Makes the file "autoloaded."
# Used with 'config.watchable_dirs['lib'] = [:rb]' in the application.rb file.
require_dependency "#{Rails.root}/lib/steam_api"

class HomeController < ApplicationController
  def index
    @player = Player.find(session[:player_id]) if session[:player_id]
    @library = @player.games if session[:player_id]
  end

  def search
    @result = SteamAPI.get_steam_ID(params[:id])
  end
end
