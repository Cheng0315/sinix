class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :index
  end

  helpers do
    def is_logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find {|user| user.id == session[:user_id]}
    end

    def input_does_not_contain_empty_field(user_input)
      !user_input.find {|type, input| input == ""}
    end
  end
end
