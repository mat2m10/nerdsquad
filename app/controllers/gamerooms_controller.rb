class GameroomsController < ApplicationController
  before_action :set_gameroom, only: %i[show update destroy]
  skip_before_action :authenticate_user!
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
    @gameroom.name = @gameroom.clone.name
  end

  def show
    @clone = @gameroom.clone
    @game = @clone.game
    @message = Message.new
    if @gameroom.users.include? current_user
      @connection = Connection.find_by(user: current_user, gameroom: @gameroom)
    elsif @gameroom.users.length < @clone.number_of_players
      @connection = Connection.create(user: current_user, gameroom: @gameroom)
    else
      redirect_to games_path
    end
  end

  def update
    @gameroom.update(gameroom_params)
    redirect_to @gameroom
  end

  def destroy
    if @gameroom.destroy
      flash[:success] = 'Game was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to user_path(current_user)
  end

  private

  def gameroom_params
    params.require(:gameroom).permit(:name)
  end

  def set_gameroom
    @gameroom = Gameroom.find(params[:id])
  end
end
