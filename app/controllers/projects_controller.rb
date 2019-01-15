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
      @date_created = Time.now.strftime('%F')
      @project = Project.create(name: @project_name, date_created: @date_created)
      add_models_to_project(@project, @models_hash)
      @user.projects << @project
      redirect :"projects/#{@project_name}"
    else
      redirect "/login"
    end
  end

  get "/projects/:id" do
    if user_is_logged_in
      @project = Project.find {|project| project.id == params[:id].to_i}
      @models_hash = convert_array_of_model_hashes_to_hash_of_model_names(@project.models)
      @project_name = @project.name
      erb :"projects/show_project"
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

  get "/projects/:id/edit" do
    if user_is_logged_in && !!current_user.projects.map {|project| project.id}.include?(params[:id].to_i)
      @project = current_user.projects.find(params[:id].to_i)
      erb :"projects/edit_project"
    else
      redirect "/login"
    end
  end
end
