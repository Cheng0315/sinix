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
    def user_is_logged_in
      !!session[:user_id]
    end

    def current_user
      User.find {|user| user.id == session[:user_id]}
    end

    def user_inputs_does_not_contain_empty_field(user_input)
      !user_input.find {|type, input| input == ""}
    end

    def url_name_matches_users_full_name(url_name)
      users_full_name = "#{current_user.first_name}-#{current_user.last_name}"
      url_name ==  users_full_name
    end
  end
end
