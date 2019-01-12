class UsersController < ApplicationController
  get "/login" do
    erb :index
  end

  get "/signup" do
    erb :"users/create_user"
  end
end
