class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
   # authorize @user
    @games = @user.games
  end

  def all
    @user = User.find(params[:user_id])
    authorize @user
    @games = @user.games
  end

  def edit
    authorize current_user
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    authorize @user
    redirect_to @user, notice: 'Successfully updated 😃'
  end

  private

  def user_params
    # Celui qui cree le game c'est le current user
    params.require(:user).permit(:description, :username, :photo)
  end
end
