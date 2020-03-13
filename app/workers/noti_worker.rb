class NotiWorker
  include Sidekiq::Worker

  def perform(user_id, story_id)
    user = User.find_by id: user_id
    story = Story.find_by id: story_id
    NotiMailer.notification(user, story).deliver_now
  end
end
