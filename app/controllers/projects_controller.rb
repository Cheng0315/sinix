class ProjectsController < ApplicationController

  get "/projects/new" do
    if user_is_logged_in
      erb :'projects/create_project/number_of_models'
    else
      redirect "/login"
    end
  end

  post "/projects/new/model-names" do
    @num_of_models = params[:num_of_models].to_i
    erb :'projects/create_project/model_names'
  end

  post "/projects" do
    if user_is_logged_in
      @user = current_user
      @project_name = params[:project_name]
      @models_hash = params[:models]
      @project = Project.create(name: @project_name, date_created: Time.now.strftime('%F'))
      add_models_to_project(@project, @models_hash)
      @user.projects << @project
      erb :'projects/show_project'
    else
      redirect "/login"
    end
  end

  get "/projects" do
    if user_is_logged_in
      @user = current_user
      @projects = Project.all
      erb :'projects/projects'
    else
      redirect "/login"
    end
  end


end
