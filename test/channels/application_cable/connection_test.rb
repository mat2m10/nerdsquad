require "test_helper"

class ApplicationCable::ConnectionTest < ActionCable::Connection::TestCase
  test "connects as the signed-in user" do
    user = create_user
    connect env: { "warden" => Struct.new(:user).new(user) }
    assert_equal user, connection.current_user
  end

  test "rejects a visitor who is not signed in" do
    assert_reject_connection { connect env: { "warden" => Struct.new(:user).new(nil) } }
  end
end
