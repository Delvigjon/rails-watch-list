class MoviesController < ApplicationController
  include HTTParty

  # Action pour les films populaires
  def popular
    api_key = ENV['TMDB_API_KEY'] # Récupère la clé API depuis les variables d'environnement
    response = HTTParty.get("https://api.themoviedb.org/3/movie/popular?api_key=#{api_key}&language=fr-FR")
    
    if response&.success?
      @movies = response.parsed_response["results"]
    else
      @movies = []
      flash[:alert] = "Impossible de récupérer les films populaires pour le moment."
    end
  rescue StandardError => e
    Rails.logger.error("Erreur API (popular): #{e.message}")
    @movies = []
    flash[:alert] = "Une erreur est survenue lors de la connexion à l'API."
  end

  # Action pour les films recommandés
  def recommended
    api_key = ENV['TMDB_API_KEY'] # Récupère la clé API depuis les variables d'environnement
    response = HTTParty.get("https://api.themoviedb.org/3/movie/top_rated?api_key=#{api_key}&language=fr-FR")
    
    if response&.success?
      @movies = response.parsed_response["results"]
    else
      @movies = []
      flash[:alert] = "Impossible de récupérer les films recommandés pour le moment."
    end
  rescue StandardError => e
    Rails.logger.error("Erreur API (recommended): #{e.message}")
    @movies = []
    flash[:alert] = "Une erreur est survenue lors de la connexion à l'API."
  end
end
