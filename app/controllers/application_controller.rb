require "rack-flash"

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    if user_is_logged_in
      redirect "/login"
    else
      erb :index
    end
  end

  helpers do
    def user_is_logged_in
      !!session[:user_id]
    end

    def current_user
      User.find {|user| user.id == session[:user_id]}
    end

    def user_inputs_does_not_contain_empty_field(user_input)
      !user_input.find {|type, input| input.scan(/\w/).empty?}
    end

    def url_name_matches_user_slug_name(url_name)
      users_full_name = "#{current_user.first_name}-#{current_user.last_name}"
      url_name ==  users_full_name
    end

    def project_belongs_to_user(project_id)
      !!current_user.projects.map {|t| t.id}.include?(project_id.to_i)
    end

    def project_exists_in_database(project_id)
      Project.find {|project| project.id == params[:id].to_i} != nil
    end

    def add_models_to_project(project, models_hash)
      models_hash.each_value do |model_name|
        model = Model.create(name: convert_to_snake_case(model_name))
        project.models << model
      end
    end

    def convert_array_of_model_hashes_to_hash_of_model_names(array_hashes)
      models_hash = {}
        array_hashes.each_with_index do |hash, index|
          models_hash["model_#{index +1}_name"] = hash.name
        end
      models_hash
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
          controllers += " <i class='fas fa-file-alt'></i> #{model[1]}s_controller.rb"
        else
          controllers += " <i class='fas fa-file-alt'></i> #{model[1]}s_controller.rb<br>    "
        end
      end
      controllers
    end

    def add_models(models_hash)
      models = ""
      models_hash.each_with_index do |model, index|
        if index == models_hash.length - 1
          models += " <i class='fas fa-file-alt'></i> #{model[1]}.rb"
        else
          models += " <i class='fas fa-file-alt'></i> #{model[1]}.rb<br>    "
        end
      end
      models
    end

    def add_views_folders_and_files(models_hash)
      views = ""

      models_hash.each_with_index do |model, index|
        if index == 0
          views += "<i class='far fa-folder-open'></i> #{model[1]}s<br>"
        else
          views += "    <i class='far fa-folder-open'></i> #{model[1]}s<br>"
        end

        if index == models_hash.length - 1
          views += "       <i class='fas fa-file-alt'></i> #{model[1]}s.erb<br>"
          views += "       <i class='fas fa-file-alt'></i> create_#{model[1]}.erb<br>"
          views += "       <i class='fas fa-file-alt'></i> edit_#{model[1]}.erb<br>"
          views += "       <i class='fas fa-file-alt'></i> show_#{model[1]}.erb"
        else
          views += "       <i class='fas fa-file-alt'></i> #{model[1]}s.erb<br>"
          views += "       <i class='fas fa-file-alt'></i> create_#{model[1]}.erb<br>"
          views += "       <i class='fas fa-file-alt'></i> edit_#{model[1]}.erb<br>"
          views += "       <i class='fas fa-file-alt'></i> show_#{model[1]}.erb<br>"
        end
      end

      views
    end

    def create_migration_files(models_hash)
      id = 1
      migration_files = ""

      models_hash.each_with_index do |model, index|
        if index == models_hash.length - 1
          migration_files += " <i class='fas fa-file-alt'></i> 00#{id}_create_#{model[1]}s.rb"
          id += 1
        else
          migration_files += " <i class='fas fa-file-alt'></i> 00#{id}_create_#{model[1]}s.rb<br>    "
          id += 1
        end
      end

      migration_files
    end

    def display_controller_classes(models_hash)
      controller_classes = ""

      models_hash.each_with_index do |model, index|
        controller_classes += "class #{split_snake_case_with_s_as_last_char(model[1])}Controller < ApplicationController<br><br>"
        controller_classes += "end<br><br>"
      end

      controller_classes + "                "
    end

    def display_model_classes(models_hash)
      model_classes = ""

      models_hash.each_with_index do |model, index|
        model_classes += "class #{split_snake_case_and_capitalize_1st_char(model[1])} < ActiveRecord::Base<br><br>"
        model_classes += "end<br><br>"
      end

      model_classes
    end

    def display_migration_files(models_hash)
      migration_files = ""

      models_hash.each_with_index do |model, index|
        migration_files += "class Create#{split_snake_case_with_s_as_last_char(model[1])} < ActiveRecord::Migration<br>"
        migration_files += "  def change<br>"
        migration_files += "    create_table :#{table_name(model[1])}s do |t|<br><br>"
        migration_files += "    end<br>"
        migration_files += "  end<br>"
        migration_files += "end<br><br><br>"
      end

      migration_files
    end

    def use_controllers(models_hash)
      controllers = ""
      models_hash.each_value do |model_name|
        controllers += "use #{split_snake_case_with_s_as_last_char(model_name)}Controller<br>"
      end

      controllers
    end


    def update_models_name(models_hash)
      models_hash.each do |id, name|
        find_model = Model.find {|m| m.id == id.to_i}
        find_model.update(name: convert_to_snake_case(name))
      end
    end

    def convert_to_snake_case(name)
      name.split(' ').join("_").downcase
    end

    def split_snake_case_with_s_as_last_char(name)
      name.split("_").map(&:capitalize).join('') + "s"
    end

    def split_snake_case_and_capitalize_1st_char(name)
      name.split("_").map(&:capitalize).join('')
    end

    def split_snake_case_join_w_space(name)
      name.split("_").join(' ')
    end

  end
end
