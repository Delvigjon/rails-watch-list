# app/controllers/movies_controller.rb
class MoviesController < ApplicationController
  include HTTParty  # Assurez-vous d'inclure HTTParty

  # Action pour les films populaires
  def popular
    api_key = ENV['TMDB_API_KEY'] || '55df2ad03cdd5178b8474e96a36b8e43'  # Remplacer par votre clé API si nécessaire
    response = HTTParty.get("https://api.themoviedb.org/3/movie/popular?api_key=#{api_key}&language=fr-FR")
    
    if response.success?
      @movies = response.parsed_response["results"]
    else
      @movies = []
      flash[:alert] = "Impossible de récupérer les films populaires pour le moment."
    end
  end

  # Action pour les films recommandés
  def recommended
    api_key = ENV['TMDB_API_KEY'] || '55df2ad03cdd5178b8474e96a36b8e43'  # Remplacer par votre clé API si nécessaire
    response = HTTParty.get("https://api.themoviedb.org/3/movie/top_rated?api_key=#{api_key}&language=fr-FR")
    
    if response.success?
      @movies = response.parsed_response["results"]
    else
      @movies = []
      flash[:alert] = "Impossible de récupérer les films recommandés pour le moment."
    end
  end
end
