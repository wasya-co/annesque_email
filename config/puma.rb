
# Puma can serve each request in a thread from an internal thread pool.
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
threads threads_count, threads_count

## Specifies the `port` that Puma will listen on to receive requests
# port ENV.fetch("PORT") { 9002 }
bind "tcp://0.0.0.0:#{ENV.fetch('PORT', 9002)}"

# Specifies the `environment` that Puma will run in.
environment ENV.fetch("RAILS_ENV") { "production" }

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked web server processes. If using Docker, typically 2-4 workers.
workers ENV.fetch("WEB_CONCURRENCY") { 2 }

# Use preload_app! when using workers
preload_app!

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

# Logging
stdout_redirect "log/puma.stdout.log", "log/puma.stderr.log", true

# Graceful shutdown
on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end
