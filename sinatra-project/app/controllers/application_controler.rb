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
        flash[:message] = "You can't do that while you are logged in."
        redirect "/users"
      end
    end

    get '/signup' do 
      if logged_in?
        flash[:message] ="You can't do that while you are logged in."
        redirect "/users"
      end
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
      if logged_in?
        session.clear
        flash[:message] = "Successful logout."
        redirect "/"
      end
    end

  # helper methods

        def logged_in?
          !!session[:user_id]
        end
    
        def current_user
            @current_user ||= User.find(session[:user_id]) if session[:user_id]
        end

        def youtube_embed(youtube_url)
          if youtube_url[/youtu\.be\/([^\?]*)/]
            youtube_id = $1
          else
            # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
            youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
            youtube_id = $5
          end
          %Q{<iframe title="YouTube video player" width="640" height="390" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>}
        end
    # helper methods

end