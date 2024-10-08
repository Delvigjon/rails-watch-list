class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy, :add_movie]

  def new
    @list = List.new
  end

  def index
    @lists = List.all
  end

  def show
  end

  def create
    @list = List.new(list_params)

    if @list.save
      redirect_to lists_path, notice: "List was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @list.update(list_params)
      redirect_to @list, notice: 'List was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_path, notice: 'List was successfully destroyed.'
  end

  # Action pour ajouter un film à une liste (par exemple, une watchlist)
  def add_movie
    @movie = Movie.find(params[:movie_id])

    # Vérifier si le film est déjà dans la liste
    unless @list.movies.exists?(id: @movie.id)
      if @list.movies << @movie
        render json: { success: true, message: "Film ajouté à la liste avec succès." }
      else
        render json: { success: false, message: "Erreur lors de l'ajout du film." }
      end
    else
      render json: { success: false, message: "Ce film est déjà dans la liste." }
    end
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :background_image_url, :photo)
  end
end
