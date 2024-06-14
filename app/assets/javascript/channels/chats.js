App.chats = App.cable.subscriptions.create("ChatChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    var chat = $('#chats-list').find("[data-chat-id='" + data['chat_id'] + "']");
 
    if (data['window'] !== undefined) {
      var chat_visible = chat.is(':visible');
 
      if (chat_visible) {
        var messages_visible = (chat).find('.panel-body').is(':visible');
 
        if (!messages_visible) {
          chat.removeClass('panel-default').addClass('panel-success');
        }
        chat.find('.messages-list').find('ul').append(data['message']);
      }
      else {
        $('#chats-list').append(data['window']);
        chat = $('#chats-list').find("[data-chat-id='" + data['chat_id'] + "']");
        chat.find('.panel-body').toggle();
      }
    }
    else {
      chat.find('ul').append(data['message']);
    }
 
    var messages_list = chat.find('.messages-list');
    var height = messages_list[0].scrollHeight;
    messages_list.scrollTop(height);
  },
  speak: function(message) {
    return this.perform('speak', {
      message: message
    });
  }
});
$(document).on('submit', '.new_message', function(e) {
  e.preventDefault();
  var values = $(this).serializeArray();
  App.chats.speak(values);
  $(this).trigger('reset');
});
