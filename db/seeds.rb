require "net/http"
require "json"

puts "🧹 Nettoyage de la base..."

Bookmark.destroy_all if defined?(Bookmark)
Movie.destroy_all

API_KEY  = ENV["TMDB_API_KEY"]
BASE_URL = "https://api.themoviedb.org/3"

if API_KEY.nil? || API_KEY.strip.empty?
  raise "TMDB_API_KEY manquant. Ajoute ta clé API."
end

# ==============================
# 🎬 Récupération des films
# ==============================
def fetch_popular_movies(base_url, api_key, limit = 50)
  movies = []
  page = 1

  while movies.size < limit
    url = URI("#{base_url}/discover/movie?api_key=#{api_key}&sort_by=popularity.desc&page=#{page}&language=fr-FR")
    response = Net::HTTP.get_response(url)

    unless response.is_a?(Net::HTTPSuccess)
      raise "Erreur TMDB: #{response.code}"
    end

    data = JSON.parse(response.body)
    results = data["results"] || []

    break if results.empty?

    movies.concat(results)
    page += 1
  end

  movies.first(limit)
end

puts "🎬 Récupération des films..."
movies = fetch_popular_movies(BASE_URL, API_KEY, 50)

puts "💾 Création des films..."

movies.each_with_index do |movie_data, index|
  # ⚠️ On skip les films sans image
  next if movie_data["poster_path"].nil?

  movie = Movie.new(
    title: movie_data["title"],
    overview: movie_data["overview"].presence || "Description indisponible",
    poster_url: "https://image.tmdb.org/t/p/w500#{movie_data["poster_path"]}",
    rating: movie_data["vote_average"] || 0
  )

  if movie.save
    puts "✅ #{index + 1} - #{movie.title}"
  else
    puts "❌ ERREUR #{movie.title} : #{movie.errors.full_messages.join(", ")}"
  end
end

puts "🎉 Seed terminé : #{Movie.count} films créés"
