import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["trending", "topRated"]

  connect() {
    this.apiKey = document.querySelector('meta[name="tmdb-key"]')?.content
    this.baseUrl = "https://api.themoviedb.org/3"
    this.imageBaseUrl = "https://image.tmdb.org/t/p/w500"

    if (!this.apiKey) {
      console.error("TMDB API key introuvable")
      return
    }

    this.loadTrendingMovies()
    this.loadTopRatedMovies()
  }

  async loadTrendingMovies() {
    try {
      const response = await fetch(`${this.baseUrl}/trending/movie/week?api_key=${this.apiKey}&language=fr-FR`)
      const data = await response.json()
      this.renderMovies(data.results || [], this.trendingTarget)
    } catch (error) {
      console.error("Erreur tendances :", error)
      this.trendingTarget.innerHTML = `<p class="home-section__text">Impossible de charger les tendances.</p>`
    }
  }

  async loadTopRatedMovies() {
    try {
      const response = await fetch(`${this.baseUrl}/movie/top_rated?api_key=${this.apiKey}&language=fr-FR`)
      const data = await response.json()
      this.renderMovies(data.results || [], this.topRatedTarget)
    } catch (error) {
      console.error("Erreur top rated :", error)
      this.topRatedTarget.innerHTML = `<p class="home-section__text">Impossible de charger les films les mieux notés.</p>`
    }
  }

  renderMovies(movies, container) {
    container.innerHTML = ""

    movies.slice(0, 8).forEach((movie) => {
      if (!movie.poster_path) return

      const title = movie.title || "Titre indisponible"
      const rating = movie.vote_average ? `${movie.vote_average.toFixed(1)} / 10` : "Non noté"
      const overview = this.truncate(movie.overview || "Pas de description disponible.", 120)

      const card = document.createElement("article")
      card.classList.add("home-movie-card")

      card.innerHTML = `
        <div class="home-movie-card__poster" style="background-image: url('${this.imageBaseUrl}${movie.poster_path}')"></div>
        <div class="home-movie-card__body">
          <h3 class="home-movie-card__title">${title}</h3>
          <div class="home-movie-card__meta">Note : ${rating}</div>
          <p class="home-movie-card__text">${overview}</p>
        </div>
      `

      container.appendChild(card)
    })
  }

  truncate(text, maxLength) {
    if (text.length <= maxLength) return text
    return `${text.substring(0, maxLength)}...`
  }
}
