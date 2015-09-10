class SessionsController < ApplicationController
  def create
    session[:player_id] = @player.id

    redirect_to root_path
  end

  def destroy
    reset_session

    redirect_to root_path
  end
end
