require_relative "environment"
env :PATH, ENV['PATH']
set :environment, Rails.env
set :output, "log/cron_job.log"

every :sunday, at: "9:00am" do
  rake "noti:weekly_noti"
end
