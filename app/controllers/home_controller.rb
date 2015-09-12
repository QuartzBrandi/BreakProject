# Makes the file "autoloaded."
# Used with 'config.watchable_dirs['lib'] = [:rb]' in the application.rb file.
require_dependency "#{Rails.root}/lib/steam_api"

class HomeController < ApplicationController
  def index
    if session[:player_id]
      @player = Player.find(session[:player_id])
      update_player_library if player.updated_at < Time.now - 86400

      @library = @player.games

    end
  end

  def search
    steamid = SteamAPI.get_steamid(params[:id])
    # if steamid returns false / -1 do something
    player = SteamAPI.get_player_summary(steamid) unless steamid == false
    @player = Player.new(player)
  end

  private

  # Updating player's library once a day.
  # Saves the game to the database if not saved.
  # Updates playtime of each game.
  def update_player_library
    games = SteamAPI.get_player_library(@player.steamid)
    games.each do |game|
      unless Game.find_by(appid: game[:appid])

        @player.games << Game.create(game)
      end
    end
    @player.update(updated_at: Time.now)
  end


  games = SteamAPI.get_player_library(player.steamid)
  games.each do |game|
    record = Playtime.create(playtime_total: game[:playtime_total])
    record.game = Game.create(game)
    record.player = player
  end

  library = SteamAPI.get_player_library(@player.steamid)
  library.each do |game|
    pop = SteamAPI.get_game_population(game[:appid])
    game[:population] = pop
  end

  def create_playtime(player, game_results)
    playtime = Playtime.create(playtime_total: game_results[:playtime_total])
    playtime.game = Game.create(game_results.reject { |key| key == :playtime_total })
    playtime.player = player
  end

  def update_playtime(player, game_results)
    game = Game.find_by(appid: game_results[:appid])
    playtime = Playtime.find_by(player_id: player.id, game_id: game.id)
    playtime.update(playtime_total: game_results[:playtime_total])
  end
end
