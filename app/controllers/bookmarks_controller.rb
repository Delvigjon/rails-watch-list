class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:destroy]

  def new
    @list = List.find(params[:list_id])
    @bookmark = @list.bookmarks.build
  end

  def create
    @list = List.find(params[:list_id])
    @movie = Movie.new(movie_params)

    if @movie.save
      @bookmark = @list.bookmarks.build(movie: @movie, comment: params[:bookmark][:comment])
      if @bookmark.save
        redirect_to @list, notice: "Bookmark was successfully created."
      else
        render :new
      end
    else
      render :new
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), notice: "Bookmark was successfully destroyed."
  end

  private

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment)
  end

  def movie_params
    params.require(:bookmark).permit(:title, :overview, :poster_url, :rating)
  end
end
