class GameroomsController < ApplicationController
  before_action :set_gameroom, only: %i[show update]
  def index    
    @gamerooms = Gameroom.all    
  end

  def new
    @gameroom = Gameroom.new
    @gameroom.save
    redirect_to @gameroom
  end

  def create
    @gameroom = Gameroom.new(gameroom_params)
  end

  def show
    @clone = @gameroom.clone
    @game = @clone.game
    @message = Message.new
    # Check the number of users
    number_connected_users = @gameroom.users.length
    if @gameroom.users.include? current_user
      @connection = Connection.find_by(user: current_user, gameroom:@gameroom)
    else
      if number_connected_users < @clone.number_of_players
        @connection = Connection.create(user: current_user, gameroom:@gameroom)
      else
        redirect_to games_path
      end
    end
  end

  def update
    @gameroom.update(gameroom_params)
    redirect_to @gameroom
  end

  private

  def gameroom_params
    params.require(:gameroom).permit(:name)
  end

  def set_gameroom
    @gameroom = Gameroom.find(params[:id])
  end
end
