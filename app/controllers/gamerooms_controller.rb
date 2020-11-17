class GameroomsController < ApplicationController
    def show
        @gameroom = Gameroom.find(params[:id])
        @message = Message.new
    end
    
end
