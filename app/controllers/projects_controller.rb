class ProjectsController < ApplicationController

  get "/projects/new" do
    erb :'projects/create_project/number_of_models'
  end

  post "/projects/new/models-names" do
    @num_of_models = params[:num_of_models].to_i
    erb :'projects/create_project/models_name'
  end

  post "/projects" do
    "hello"
  end
end
