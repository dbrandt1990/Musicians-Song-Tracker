class UsersController < ApplicationController
    get '/users' do 
        @user = User.find(session[:user_id])
        erb :"/users/show"
    end
end