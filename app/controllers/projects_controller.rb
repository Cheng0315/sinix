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
      @date_created = Time.now.strftime('%F')
      @project = Project.create(name: params[:project_name], date_created: @date_created, description: params[:description])
      add_models_to_project(@project, params[:models])
      @user.projects << @project
      redirect "/projects/#{@project.id}"
    else
      redirect "/login"
    end
  end

  get "/projects/:id" do
    if user_is_logged_in && Project.find {|project| project.id == params[:id].to_i} != nil
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

  patch "/projects/:id" do
    if user_is_logged_in
      @project = Project.find {|project| project.id == params[:id].to_i}
      @project.update(name: params[:project_name], description: params[:description])
      update_models_name(params[:models])
      redirect "/projects/#{@project.id}"
    else
      redirect "/login"
    end
  end

  delete "/projects/:id/delete" do
    @project_belongs_to_user = !!current_user.projects.map {|t| t.id}.include?(params[:id].to_i)
      if user_is_logged_in && @project_belongs_to_user
        current_user.projects.find(params[:id].to_i).destroy
        redirect "/projects"
      else
        redirect "/login"
      end
  end



end
