namespace :noti do
  task weekly_noti: :environment do
    WeeklyWorker.perform_in 30.seconds
  end
end
