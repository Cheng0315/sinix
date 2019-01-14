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

    def add_controllers(models_hash)
      controllers = ""
      models_hash.each_with_index do |model, index|
        if index == models_hash.length - 1
          controllers += "<a href='/projects/new'>#{model[1]}s_controller.rb</a>"
        else
          controllers += "<a href='/projects/new'>#{model[1]}s_controller.rb</a><br>        "
        end
      end
      controllers
    end

    def add_models(models_hash)
      models = ""
      models_hash.each_with_index do |model, index|
        if index == models_hash.length - 1
          models += "#{model[1]}.rb"
        else
          models += "#{model[1]}.rb<br>        "
        end
      end
      models
    end

    def add_views_folders_and_files(models_hash)
      views = ""

      models_hash.each_with_index do |model, index|
        if index == 0
          views += "<a href='/projects/new'>#{model[1]}s</a><br>"
        else
          views += "        <a href='/projects/new'>#{model[1]}s</a><br>"
        end

        if index == models_hash.length - 1
          views += "          #{model[1]}s.erb<br>"
          views += "          create_#{model[1]}.erb<br>"
          views += "          edit_#{model[1]}.erb<br>"
          views += "          show_#{model[1]}.erb"
        else
          views += "          #{model[1]}s.erb<br>"
          views += "          create_#{model[1]}.erb<br>"
          views += "          edit_#{model[1]}.erb<br>"
          views += "          show_#{model[1]}.erb<br>"
        end
      end

      views
    end

    def create_migration_files(models_hash)
      id = 1
      migration_files = ""

      models_hash.each_with_index do |model, index|
        if index == models_hash.length - 1
          migration_files += "00#{id}_create_#{model[1]}s.rb"
          id += 1
        else
          migration_files += "00#{id}_create_#{model[1]}s.rb<br>        "
          id += 1
        end
      end

      migration_files
    end

    def display_controller_classes(models_hash)
      controller_classes = ""

      models_hash.each_with_index do |model, index|
        controller_classes += "class #{capitalize_model_name_with_s_as_last_char(model[1])}Controller < Application<br><br>"
        controller_classes += "end<br><br>"
      end

      controller_classes
    end

    def display_model_classes(models_hash)
      model_classes = ""

      models_hash.each_with_index do |model, index|
        model_classes += "class #{capitalize_model_name(model[1])} < ActiveRecord::Base<br><br>"
        model_classes += "end<br><br>"
      end

      model_classes
    end





  end
end
