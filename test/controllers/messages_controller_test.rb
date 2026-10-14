require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  include ActionCable::TestHelper

  test "posting a chat message saves it and broadcasts it to the gameroom" do
    user = create_user
    game = create_full_game(user)
    sign_in user
    post game_clones_path(game)
    gameroom = Gameroom.last

    assert_broadcasts(GameroomChannel.broadcasting_for(gameroom), 1) do
      post gameroom_messages_path(gameroom), params: { message: { content: "hello" } }
    end
    message = gameroom.messages.last
    assert_equal ["hello", user], [message.content, message.user]
    assert_redirected_to gameroom_path(gameroom, anchor: "message-#{message.id}")
  end
end
