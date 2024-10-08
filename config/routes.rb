Rails.application.routes.draw do
  # Route pour ajouter un film à une liste spécifique (par exemple, une watchlist)
  post '/lists/:id/add_movie', to: 'lists#add_movie', as: :add_movie_to_list

  # Route racine vers la page d'accueil
  root to: 'pages#home'

  # Autres routes pour les films populaires et recommandés
  get 'popular', to: 'movies#popular', as: :movies_popular
  get 'recommended', to: 'movies#recommended', as: :movies_recommended

  # Routes pour les listes et les bookmarks
  resources :lists do
    resources :bookmarks, only: [:new, :create]
  end

  resources :bookmarks, only: [:destroy]
end
