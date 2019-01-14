class ProjectsController < ApplicationController

  get "/projects/new" do
    erb :'projects/create_project/number_of_models'
  end

  post "/projects/new/model-names" do
    @num_of_models = params[:num_of_models].to_i
    erb :'projects/create_project/model_names'
  end

  post "/projects" do
    @project_name = params[:project_name]
    @models_hash = params[:models]
    @project = Project.create(name: @project_name)
    add_models_to_project(@project, @models_hash)
    binding.pry
    erb :'projects/show_project'
  end


end
