require 'test_helper'

class ChatTest < ActiveSupport::TestCase
  test "should not save chat without title" do
    chat = Chat.new
    assert_not chat.save, "Saved the chat without a title"
  end
end
