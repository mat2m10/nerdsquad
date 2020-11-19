class TokensController < ApplicationController
  before_action :set_game, only: %i[new create show]

  def new
    @token = Token.new
  end

  def create
    number_of_tokens = params[:token][:number_of_tokens].to_i
    number_of_tokens.times do
      @token = Token.new(token_params)
      @token.game = @game
      if @token.save
        flash[:success] = "Token successfully created"
      else
        flash[:error] = "Something went wrong"
        render 'new'
      end
    end
    redirect_to game_path(@game)
  end

  def update
    @token = Token.find(params[:id])
    @token.update!(token_params)
    if @token.game.gamerooms.last
      GameroomChannel.broadcast_to(
        @token.game.gamerooms.last,
        "moved"
      )
    else
      redirect_to game_path(params[:game_id])
    end
    if @token.game.gamerooms.last
      redirect_back(fallback_location: gameroom_path(@token.game.gamerooms.last))
    end
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def token_params
    params.require(:token).permit(:photo, :name, :number_of_tokens, :posX, :posY)
  end
end
