require 'test_helper'

class ChatsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get chats_index_url
    assert_response :success
  end

  test "can create a chat" do
    get "/chats"
    assert_response :success
   
    post "/chats",
      params: { chat: {title: "test chat title" }}
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "p", "Title:\n  can create"
  end
end
