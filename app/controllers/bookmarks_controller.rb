class BookmarksController < ApplicationController

    before_action :set_bookmark, only: [:destroy]
  
    def new
      @bookmark = Bookmark.new
    end
  
    def create
      @bookmark = Bookmark.new(bookmark_params)
      @bookmark.list = List.find(params[:list_id])
      
      if @bookmark.save
        redirect_to @bookmark.list, notice: "Bookmark was successfully created."
      else
        render :new
      end
    end
  
    def destroy
      @bookmark.destroy
      redirect_to bookmark_url, notice: "Bookmark was successfully destroyed.", status: :see_other
    end
  
    private
  
    def set_bookmark
      @bookmark = Bookmark.find(params[:id])
    end
  
    def bookmark_params
      params.require(:bookmark).permit(:comment, :movie_id, :list_id)
    end
  end
  