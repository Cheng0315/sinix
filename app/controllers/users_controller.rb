require './config/environment'
class UsersController < ApplicationController

  get "/login" do
    if user_is_logged_in
      @user = current_user
      redirect "/users/#{@user.first_name}-#{@user.last_name}"
    else
      erb :index
    end
  end

  post "/login" do
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.first_name}-#{@user.last_name}"
    else
      redirect "/login"
    end
  end

  get "/users/:name" do
    if user_is_logged_in && url_name_matches_users_full_name(params[:name])
      @user = current_user
      erb :"projects/projects"
    else
      redirect "/login"
    end
  end

  get "/users/:name/profile" do
    if user_is_logged_in && url_name_matches_users_full_name(params[:name])
      erb :"users/show_user"
    else
      redirect "/login"
    end
  end

  get "/signup" do
    if user_is_logged_in
      @user = current_user
      redirect "/users/#{@user.first_name}-#{@user.last_name}"
    else
      erb :"users/create_user"
    end
  end

  post "/signup" do
    if user_inputs_does_not_contain_empty_field(params[:user])
      @user = User.create(params[:user])
      session[:user_id] = @user.id
      redirect "/users/#{@user.first_name}-#{@user.last_name}"
    else
      redirect "/signup"
    end
  end

  get "/users/:name/edit" do
    if user_is_logged_in && url_name_matches_users_full_name(params[:name])
      @user = current_user
      erb :"users/edit_user"
    else
      redirect "/login"
    end
  end

  patch "/users/:name" do
    if user_inputs_does_not_contain_empty_field(params[:user])
      @user = current_user
      @user.update(params[:user])
      redirect "/users/#{@user.first_name}-#{@user.last_name}"
    else
      @user = current_user
      redirect "/users/#{@user.first_name}-#{@user.last_name}/edit"
    end
  end

  get "/logout" do
    if user_is_logged_in
      session.clear
      redirect "/"
    else
      redirect "/"
    end
  end
end
