class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notification_channel_#{message_user.id}"
  end

  def unsubscribed; end
end
