class SongsController < ApplicationController
    get '/songs/new' do 
        erb :"/songs/new"
    end

    post '/songs' do
        @song = Song.create(:name => params[:name], :video => params[:video],:tabs => params[:tabs],:lyrics => params[:lyrics],:learned => params[:learned])
    end
end