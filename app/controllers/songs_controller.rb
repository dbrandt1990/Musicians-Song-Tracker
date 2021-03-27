class SongsController < ApplicationController
    
    get '/songs/new' do 
        if logged_in?
            erb :"/songs/new"
        end
    end

    post '/songs' do
        embed_video = youtube_embed(params[:video])
        song = Song.create(:name => params[:name], :video => embed_video,:tabs => params[:tabs],:lyrics => params[:lyrics],:learned => params[:learned])
        user = User.find(session[:user_id])
        user.songs << song
        redirect "/users"
    end

    get '/songs/:id' do 
        if logged_in?
            @song = Song.find(params[:id])
            erb :"/songs/show"
        end
    end

    get '/songs/:id/edit' do
        @song = Song.find(params[:id])
        user = current_user
        if logged_in? && @song.user_id == user.id
            erb :"/songs/edit"
        else
            redirect "/users"
        end
    end

    get '/songs/:id/delete' do
        song = Song.find(params[:id])
        user = current_user
        if logged_in? && song.user_id == user.id
            Song.destroy(song.id)
            redirect "/users"
        else
            redirect "/"
        end
    end

    patch '/songs/:id' do 
        @song = Song.find(params[:id])
        name = params[:name]
        video = params[:video]
        tabs = params[:tabs]
        lyrics = params[:lyrics]
        notes = params[:notes]
        learned = params[:learned]

        if name != ""
            @song.update(:name =>  name)
        end
        if video != ""
            @song.update(:video =>  video)
        end
        if tabs != ""
            @song.update(:tabs =>  tabs)
        end
        if lyrics != ""
            @song.update(:lyrics =>  lyrics)
        end
        if notes != ""
            @song.update(:notes => notes)
        end
        if learned == 1 
            @song.update(:learned => true)
        else
            @song.update(:learned => false)
        end
         erb :"/songs/show"
    end
end