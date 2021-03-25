require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

    configure do
        use Rack::Flash
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "secret"
      end

    get '/' do
      if !logged_in?
        erb :index
      else
        redirect "/users"
      end
    end

    get '/signup' do 
      erb :"/users/create_user"
    end

    post '/signup' do
      @user = User.create(:username => params[:username] , :email => params[:email], :password => params[:password])
      if @user.id 
      session[:user_id] = @user.id
      redirect "/users"
      else
        flash[:message] = "Username or Email already exits"
        redirect "/signup"
      end
    end

    post '/login' do 
      if !logged_in?
        @user = User.find_by(:username => params[:username].strip)

        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect "/users"
        else
          flash[:message] = "Invalid Username or Password"
        end
      end
    end

    get '/logout' do 
      # just for develpment, add checks for login for deployment
        session.clear
        redirect "/"
    end

  # helper methods

        def redirect_if_not_logged_in
          if !logged_in?
            redirect "/?error=You have to be logged in to do that"
          end
        end
    
        def logged_in?
          !!session[:user_id]
        end
    
        def current_user
            @current_user ||= User.find(session[:user_id]) if session[:user_id]
        end

    # helper methods

end