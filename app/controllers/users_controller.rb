class UsersController < ApplicationController
   
    get '/users' do 
        if logged_in?
            @user = User.find(session[:user_id])
            erb :"/users/show"
        end
    end
end