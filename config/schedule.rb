# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron


# View config/schedule.rb converted to cron syntax
# bundle exec whenever

# Update crontab
# bundle exec whenever -i

# Overwrite the whole crontab (be careful with this one!)
# bundle exec whenever -w

# See all the options for the whenever command
# bundle exec whenever -h


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
every 1.day do
  rake 'stores_fetch'
end
