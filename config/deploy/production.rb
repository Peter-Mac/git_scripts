set :stage, :production

# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}".downcase

role :app, %w{deploy@www.myserver.com}
role :web, %w{deploy@www.myserver.com}
role :db,  %w{deploy@www.myserver.com}


# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

server 'www.myserver.com', user: 'deploy', roles: %w{web app}, my_property: :my_value
set :deploy_to, '/var/www/myproject'

set :rvm_type, :user # or :auto
set :rvm_ruby_version, 'ruby-2.1.2'

set :rails_env, 'production' # even though doc says only need to do this if it's different
