class TokensController < ApplicationController
        def new
          @token = Token.new
        end
      
        def create
          @game = Game.find(params[:game_id])
          @token = Token.new(token_params)
          @token.game = @game
          @token.save
          redirect_to game_path(@game)
        end
      
        private
      
        def token_params
          params.require(:token).permit(:photo)
        end
      end
end
