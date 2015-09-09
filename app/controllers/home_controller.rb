require_dependency "#{Rails.root}/lib/steam_api"

class HomeController < ApplicationController
  def index
    @library = Player.find(session[:player_id]) if session[:player_id]
  end

  def search
    @result
  end
end
