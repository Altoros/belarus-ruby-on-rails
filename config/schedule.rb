env :PATH, '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin'

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

# Learn more: http://github.com/javan/whenever

set :output, '/var/log/cron.log'

every 1.day, :at => '4:00 am' do
  runner "require 'rss'; RSS.fetch_aggregators"
end

every 1.day, :at => '4:30 am' do
  command "cd /home/deploy/belarus-on-rails/current && bundle exec backup perform --trigger my_backup -c ~/Backup/config.rb"
end

every :reboot do
  rake "sunspot:solr:start"
end
