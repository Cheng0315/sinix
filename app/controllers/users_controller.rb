require './config/environment'
class UsersController < ApplicationController

  get "/login" do
    if is_logged_in?
      redirect "/users/#{@user.first_name}-#{@user.last_name}"
    else
      erb :index
    end
  end

  get "/users/:name" do
    if is_logged_in?
      erb :"projects/projects"
    else
      redirect "/login"
    end
  end

  get "/users/:name/profile" do
    if is_logged_in?
      erb :"users/show_user"
    else
      redirect "/login"
    end
  end

  get "/signup" do
    if is_logged_in?
      @user = current_user
      redirect "/users/#{@user.first_name}-#{@user.last_name}"
    else
      erb :"users/create_user"
    end
  end

  post "/signup" do
    if input_does_not_contain_empty_field(params[:user])
      @user = User.create(params[:user])
      session[:user_id] = @user.id
      redirect "/users/#{@user.first_name}-#{@user.last_name}"
    else
      redirect "/signup"
    end
  end

  get "/users/:name/edit" do
    if is_logged_in?
      erb :"users/show_user"
    else
      redirect "/login"
    end
  end

  get "/logout" do
    if is_logged_in?
      session.clear
      redirect "/"
    else
      redirect "/"
    end
  end
end
