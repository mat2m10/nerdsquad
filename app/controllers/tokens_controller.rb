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

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def token_params
    params.require(:token).permit(:photo, :name, :number_of_tokens, :posX, :posY)
  end
end
