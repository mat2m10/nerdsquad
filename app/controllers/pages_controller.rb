class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  
  def home
    @gamerooms = Gameroom.all
    @user = current_user
    offset = rand(Gameroom.count)
    @gameroom = Gameroom.offset(offset).first
  end
end



