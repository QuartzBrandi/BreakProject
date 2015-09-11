class SessionsController < ApplicationController
  def create
    @player = Player.create(params_player)
    session[:player_id] = @player.id

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
