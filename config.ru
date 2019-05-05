require './config/environment'


use Rack::MethodOverride
use ProjectsController
use UsersController
run ApplicationController
