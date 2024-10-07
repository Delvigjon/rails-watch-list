require 'net/http'
require 'json'

# Remplace par ta clé API TMDb
API_KEY = '55df2ad03cdd5178b8474e96a36b8e43'

# Méthode pour récupérer un film par son titre via l'API TMDb
def fetch_movie_data(title)
  encoded_title = URI.encode_www_form_component(title)
  url = URI("https://api.themoviedb.org/3/search/movie?api_key=#{API_KEY}&query=#{encoded_title}")
  response = Net::HTTP.get(url)
  movie_data = JSON.parse(response)["results"].first

  if movie_data
    {
      title: movie_data["title"],
      overview: movie_data["overview"],
      poster_url: "https://image.tmdb.org/t/p/original#{movie_data['poster_path']}",
      rating: movie_data["vote_average"]
    }
  else
    nil
  end
end

# Créer ou mettre à jour un film avec les données récupérées de l'API
def create_or_update_movie(title)
  movie_data = fetch_movie_data(title)

  if movie_data
    Movie.find_or_create_by(title: movie_data[:title]) do |movie|
      movie.overview = movie_data[:overview]
      movie.poster_url = movie_data[:poster_url]
      movie.rating = movie_data[:rating]
    end
  else
    puts "Aucun film trouvé pour #{title}"
  end
end

# Liste de titres de films à rechercher via l'API
movie_titles = ["Wonder Woman 1984", "The Shawshank Redemption", "Titanic", "Ocean's Eight"]

# Créer ou mettre à jour les films à partir des titres
movie_titles.each do |title|
  create_or_update_movie(title)
end
