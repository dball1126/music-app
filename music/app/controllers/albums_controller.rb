class AlbumsController < ApplicationController



    def new
        @album = Album.new
        render :new
    end

    def create
        @album = Album.new(album_params)
        if @album.save
            redirect_to album_url(@album)
        else 
            flash.now[:errors] = ["Unable to create the album"]
            render :new
        end
    end

    def edit
        @album = Albumn.find(params[:id])
        render :edit
    end

    def show
        @album = Album.find(params[:id])
        render :show
    end

    def update
        @album = Albumn.find(params[:id])
        if @album.update_attributes(album_params)
            redirect_to album_url(@album)
        else
            flash.now[:errors] = ["Unable to update the album"]
            render :edit
        end
    end



    def destroy
        @album.delete
    end

    private

    def album_params
        params.require(:album).permit(:title, :year, :studio, :band_id)
    end

end