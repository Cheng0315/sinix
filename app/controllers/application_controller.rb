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

    def add_models_to_project(project, models_hash)
      models_hash.each_value do |model_name|
        model = Model.create(name: model_name)
        project.models << model
      end
    end

    def capitalize_model_name_with_s_as_last_char(model_name)
      name = model_name.split.map(&:capitalize).join('')
      if name[-1] == "s"
        name
      else
        name + "s"
      end
    end

    def capitalize_model_name(model_name)
      name = model_name.split.map(&:capitalize).join('')
    end

    def table_name(model_name)
      model_name.downcase
    end

    def add_app_controllers(models_hash)
      controllers = ""
      models_hash.each_value do |model_name|
        controllers += model_name + "s_controller.rb<br>        "
      end
      controllers
    end

    def add_models(models_hash)
      models = ""
      models_hash.each_value do |model_name|
        models += model_name + ".rb<br>        "
      end
      models
    end
  end
end
