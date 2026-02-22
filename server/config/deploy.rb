# Capistrano deploy configuration

lock "~> 3.18.0"

set :application, "spree"
set :repo_url, ENV.fetch("CAPISTRANO_REPO", "").strip
set :deploy_to, "/var/www/spree"
set :scm, :git
set :branch, ENV.fetch("CAPISTRANO_BRANCH", "master")
set :keep_releases, 5
set :linked_files, %w[config/database.yml config/master.key .env]
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets public/system storage]
set :rbenv_type, :user
set :rbenv_ruby, File.read(File.expand_path("../.ruby-version", __dir__)).strip
set :rbenv_path, "$HOME/.rbenv"
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :bundle_bins, %w[rake rails puma pumactl]
set :bundle_path, nil
set :bundle_without, %w[development test].join(" ")
set :rails_env, "production"
set :migration_role, :app
set :migration_servers, -> { primary(fetch(:migration_role)) }
set :assets_roles, %i[web app]
set :conditionally_migrate, true

namespace :deploy do
  after :published, :restart_puma do
    on roles(:app), in: :sequence, wait: 5 do
      execute :sudo, :systemctl, :restart, :puma
    end
  end
end
