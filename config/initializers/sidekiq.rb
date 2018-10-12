#Sidekiq monitor
require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == ["admin", "admin"]
end
