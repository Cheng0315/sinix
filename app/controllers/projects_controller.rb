class ProjectsController < ApplicationController

  get "/projects/new" do
    erb :'projects/create_project/number_of_models'
  end

  post "/projects/new/model-names" do
    @num_of_models = params[:num_of_models].to_i
    erb :'projects/create_project/model_names'
  end

  post "/projects" do

  end
end
