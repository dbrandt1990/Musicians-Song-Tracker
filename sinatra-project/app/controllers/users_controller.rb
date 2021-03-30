class UsersController < ApplicationController
   
    get '/users' do 
        if logged_in?
            @user = User.find(session[:user_id])
            erb :"/users/show"
        end
    end

    get '/users/practice' do 
        if logged_in?
            @user = User.find(session[:user_id])
            @songs = []
            @user.songs.each do |s| 
                if s.learned == true
                    @songs << s
                end
            end
            erb :"/users/sorted"
        end
    end

    get '/users/learn' do 
        if logged_in?
            @user = User.find(session[:user_id])
            @songs = []
            @user.songs.each do |s| 
                if s.learned == false
                    @songs << s
                end
            end
            erb :"/users/sorted"
        end
    end
end