class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name username photo])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  private

  # Only the author of a game may change it or its components.
  # Answers 404 rather than 403 so other users' ids are not confirmed.
  def require_game_owner!
    raise ActiveRecord::RecordNotFound unless @game.user_id == current_user.id
  end

  # Only players connected to a gameroom may move its pieces, chat or close it.
  def require_player!(gameroom)
    raise ActiveRecord::RecordNotFound unless gameroom&.users&.exists?(current_user.id)
  end
end
