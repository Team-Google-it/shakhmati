class SessionsController < ApplicationController
  def new
    @games = Game.available
  end

  def create
    @games = Game.available
    auth_hash = request.env['omniauth.auth']

    render :text => auth_hash.inspect
  end

  def failure
  end
end
