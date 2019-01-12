require './config/environment'
class UsersController < ApplicationController

  get "/login" do
    erb :index
  end

  get "/user/:name" do
    erb :"projects/projects"
  end

  get "/user/:name/profile" do
    erb :"users/show_user"
  end

  get "/signup" do
    erb :"users/create_user"
  end

  post "/signup" do
    if input_does_not_contain_empty_field(params[:user])
      @user = User.create(params[:user])
      session[:user_id] = @user.id
      redirect "/user/#{@user.first_name}-#{@user.last_name}"
    else
      redirect "/signup"
    end
  end

end
