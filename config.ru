require './config/environment'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

set :public, 'public'

use Rack::MethodOverride
use UsersController
use SongsController
run ApplicationController