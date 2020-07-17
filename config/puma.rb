workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_min_count = Integer(ENV['RAILS_MIN_THREADS'] || 5)
threads_max_count = Integer(ENV['RAILS_MAX_THREADS'] || 5)
threads threads_min_count, threads_max_count

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  ActiveRecord::Base.establish_connection
end