# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

require 'dotenv'
Dotenv.load

job_type :sidekiq, 'cd :path && :environment_variable=:environment bundle exec sidekiq-client push :task :output'
#
# # Learn more: http://github.com/javan/whenever
# every 2.hours do
#   command "cd /home/deployer/apps/nivose-back/current/scripts/sitemaps/ && cargo build --release && ./target/release/sitemaps #{ENV['API_URL']} #{ENV['APP_URL']} && mv sitemap.xml /home/deployer/apps/nivose-front/current/dist"
# end
#
# every 1.days do
#   run "::Order.resync_all"
# end

every 1.days, :roles => [:app] do
  sidekiq "OrderCancelWorker::Cancel"
end
