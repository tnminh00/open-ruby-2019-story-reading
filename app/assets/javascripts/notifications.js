$(document).ready(function(){
  (function() {
    App.notifications = App.cable.subscriptions.create({
      channel: 'NotificationsChannel',
    },
    {
      connected: function() {},
      disconnected: function() {},
      received: function(data) {
        $('.noti').prepend('' + data.notification);
        $('#counter').html(data.counter);
      }
    });
  }).call(this);
})
