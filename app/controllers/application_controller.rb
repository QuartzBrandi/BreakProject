class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  # Creates a game based on the Steam API call game info.
  def create_game(game_info)
    game = Game.create(game_info.except(:playtime_total))
    update_population(game)
    return game
  end

  # Updates the population of a single game by calling the Steam API.
  def update_population(game)
    population = SteamAPI.get_game_population(game.appid)
    game.update(population: population)
  end
end
