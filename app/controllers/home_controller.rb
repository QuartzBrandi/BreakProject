# Makes the file "autoloaded."
# Used with 'config.watchable_dirs['lib'] = [:rb]' in the application.rb file.
require_dependency "#{Rails.root}/lib/steam_api"

class HomeController < ApplicationController
  def index
    if session[:player_id]
      @player = Player.find(session[:player_id])
      update_player_library
      update_population_for_entire_library
      @library = @player.games
    end
  end

  def search
    if params[:type] == "vanity_url"
      steamid = SteamAPI.get_steamid(params[:id])
      # if steamid returns nil do something
      if steamid
        player = SteamAPI.get_player_summary(steamid)
        @player = Player.new(player)
      end
    end

    if params[:type] == "steamid"
      player = SteamAPI.get_player_summary(params[:id])
      @player = Player.new(player) unless player.nil?
    end
  end

  private

  # Updates the player's library once a day.
  # Saves the game to the database if not saved.
  # Updates playtime of each game.
  def update_player_library
    if @player.updated_at < Time.now - 86400 # 24hrs
      games = SteamAPI.get_player_library(@player.steamid) # query Steam API
      games.each do |game_info|
        game = Game.find_by(appid: game_info[:appid]) # game = nil if not in database
        if game
          # update the playtime
          playtime = Playtime.find_by(player_id: @player.id, game_id: game.id)
          playtime.update(playtime_total: game_info[:playtime_total])
        else
          # add game to database & player's library
          @player.games << create_game(game_info)
        end
      end
      @player.update(updated_at: Time.now)
    end
  end

  # Updates the population of every game in the player's library,
  # if it hasn't been updated in the past hour.
  def update_population_for_entire_library
    @player.games.each do |game|
      if game.updated_at < Time.now - 3600 # 1hr
        update_population(game)
      end
    end
  end

  def create_playtime(player, game_results)
  end

  def update_playtime
  end
end
