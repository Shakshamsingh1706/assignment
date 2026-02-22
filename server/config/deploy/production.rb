# Production deployment target

set :stage, :production
set :rails_env, :production

set :server, ENV["CAPISTRANO_SERVER"] || "deploy@your-server.example.com"
server fetch(:server), user: "deploy", roles: %w[web app db], primary: true
