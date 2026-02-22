# Capistrano tasks for Puma via systemd

namespace :puma do
  desc "Start Puma service"
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      execute :sudo, :systemctl, :start, :puma
    end
  end

  desc "Stop Puma service"
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      execute :sudo, :systemctl, :stop, :puma
    end
  end

  desc "Restart Puma service"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :sudo, :systemctl, :restart, :puma
    end
  end
end
