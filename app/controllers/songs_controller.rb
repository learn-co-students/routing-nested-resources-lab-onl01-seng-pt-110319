class SongsController < ApplicationController
  
  def index
    if params[:artist_id]
       @artist = Artist.find_by(id: params[:artist_id])
       if @artist
          @songs = @artist.songs
       elsif @artist.nil?
          flash[:alert] = "Artist not found."
          redirect_to artists_path 
       end
    else 
      @songs = Song.all 
      render "index"
    end
  end

  def show
    if params[:artist_id] && Artist.find_by(id: params[:artist_id])
      @artist = Artist.find_by(id: params[:artist_id])
      if @artist.songs.find { |song| song.id == params[:id].to_i }
        @song = Song.find(params[:id])
      else
        flash[:alert] = "Song not found."
        redirect_to artist_songs_path(@artist)
      end
    else 
      if params[:id] && Song.find(params[:id])
        @song = Song.find(params[:id])
      else 
        redirect_to songs_path
      end
    end
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end

end
