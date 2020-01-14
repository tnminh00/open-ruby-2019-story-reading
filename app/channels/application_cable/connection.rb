module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :message_user

    def connect
      user = User.find_by id: cookies.signed[:user_id]
      
      if user
        self.message_user = user
      else
        reject_unauthorized_connection
      end
    end
  end
end
