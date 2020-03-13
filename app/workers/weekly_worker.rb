class WeeklyWorker
  include Sidekiq::Worker

  def perform
    User.all.each do |user|
      NotiMailer.weekly_noti(user).deliver_now
    end
  end
end
