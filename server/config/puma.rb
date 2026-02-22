# Puma configuration
# Production: unix socket, shared log/pid. Development: port 3000.
# See https://puma.io/puma/Puma/DSL.html

threads 3, 3
workers ENV.fetch("WEB_CONCURRENCY", 2)

if ENV["RAILS_ENV"] == "production"
  app_root = "/var/www/spree"
  bind "unix://#{app_root}/shared/tmp/sockets/puma.sock"
  pidfile "#{app_root}/shared/tmp/pids/puma.pid"
  state_path "#{app_root}/shared/tmp/pids/puma.state"
  stdout_redirect "#{app_root}/shared/log/puma.stdout.log", "#{app_root}/shared/log/puma.stderr.log", true
else
  port ENV.fetch("PORT", 3000)
  pidfile ENV["PIDFILE"] if ENV["PIDFILE"]
end

preload_app!

plugin :tmp_restart
plugin :solid_queue if ENV["SOLID_QUEUE_IN_PUMA"]
