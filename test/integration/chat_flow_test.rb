require 'test_helper'

class ChatFlowTest < ActionDispatch::IntegrationTest
  test "can see the chats page" do
    get "/"
    assert_select "h1", "chats#index"
  end
end
