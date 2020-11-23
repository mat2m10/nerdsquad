class TokensController < ApplicationController
  before_action :set_game, only: %i[new create show update destroy]

  before_action :set_token, only: %i[update destroy]

  def new
    @token = Token.new
  end

  def create
    params[:token][:number_of_tokens].to_i.times do
      @token = Token.new(token_params)
      @token.game = @game
      @token.save
    end
    redirect_to game_token_path(params[:game_id], @token.id)
  end

  def update
    @token.update!(token_params)
    num = @token.number_of_tokens + 1
    @game.tokens[(-@token.number_of_tokens)..-2].each do |token|
      token.posX = @token.posX + num*5
      token.posY = @token.posY + num*5
      num -= 1
      token.save
    end
    if @token.game.gamerooms.last
      GameroomChannel.broadcast_to(
        @token.game.gamerooms.last,
        "moved"
      )
      redirect_back(fallback_location: gameroom_path(@token.game.gamerooms.last))
    else
      redirect_to request.referrer
    end
  end

  def destroy
    if @token.destroy
      flash[:success] = 'Object was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to @game
  end

  def destroy
    @token = Token.find(params[:id])
    if @token.destroy
      flash[:success] = 'Piece was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to @game
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_token
    @token = Token.find(params[:id])
  end

  def token_params
    params.require(:token).permit(:photo, :name, :number_of_tokens, :posX, :posY)
  end
end
