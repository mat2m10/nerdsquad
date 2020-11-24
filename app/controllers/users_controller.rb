class UsersController < ApplicationController
  def show
    @user = current_user  
    @games = @user.games
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to @user, notice: 'Your profile was successfully updated 😃'
  end

  private

  def user_params    
    params.require(:user).permit(:email, :username, :photo)
  end
end
