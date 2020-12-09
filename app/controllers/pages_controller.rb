class PagesController < ApplicationController
  def home
    @gamerooms = Gameroom.all
    @user = current_user
    offset = rand(Gameroom.count)
    @gameroom = Gameroom.offset(offset).first
  end
end
