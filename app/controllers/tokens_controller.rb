class TokensController < ApplicationController
  before_action :set_game, only: %i[new create show update destroy]
  before_action :set_token, only: %i[show edit update destroy]

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
    if request.referrer.include? 'tokens'
      num = @token.number_of_tokens + 1
      @game.tokens.last(@token.number_of_tokens).each do |token|
        token.assign_attributes(posX: @token.posX + num * 5, posY: @token.posY + num * 5,
                                width: @token.width, height: @token.height, angle: @token.angle)
        num -= 1
        token.save
      end
    end
    @token.update!(token_params)
    redirect_to request.referrer
  end

  def destroy
    if @token.destroy
      flash[:success] = 'Object was successfully deleted.'
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
    params.require(:token).permit(:photo, :name, :number_of_tokens, :posX, :posY, :height, :width, :angle)
  end
end
