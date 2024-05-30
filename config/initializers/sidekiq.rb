# Sidekiq.configure_server do | config |
#     config.redis = {url = 'redis://localhost:6379'}
# end
# Sidekiq.configure_client do | config |
#     config.redis = {url = 'redis://localhost:6379'}
# end

# extension for sidekiq to use the scheduler
require 'sidekiq/scheduler'
# sidekiq configuration, when the server starts
# scheduler has a hash of name of the action and detials of schedule
Sidekiq.configure_server do |config|
    puts("=======================================")
  config.on(:startup) do
    Sidekiq.schedule = {
      'session_update' => {
        'cron' => '*/3 * * * *', # Runs every 3 minutes
        'class' => 'SessionUpdateJob'
      }
    }
    # used to reload the schedule if its config changes dynamically
    Sidekiq::Scheduler.reload_schedule!
  end
end