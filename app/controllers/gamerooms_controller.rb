class GameroomsController < ApplicationController
  before_action :set_gameroom, only: %i[show update destroy]
  before_action -> { require_player!(@gameroom) }, only: %i[update]
  # Anyone may join an open room, so closing it is for the game's owner only.
  before_action :require_room_owner!, only: %i[destroy]
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
    @gameroom.name = @gameroom.game_clone.name
  end

  def show
    @clone = @gameroom.game_clone
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

  def require_room_owner!
    raise ActiveRecord::RecordNotFound unless @gameroom.game_clone&.game&.user_id == current_user.id
  end
end
