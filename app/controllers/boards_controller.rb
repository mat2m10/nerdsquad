class BoardsController < ApplicationController
    def new
        @board = Board.new
    end  
    def create
        @game = Game.new
        @board = Object.new(params[:board])
        if @board.save
          flash[:success] = "Object successfully created"
          redirect_to @board
        else
          flash[:error] = "Something went wrong"
          render 'new'
        end
    end
end
