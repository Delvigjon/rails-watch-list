Rails.application.routes.draw do
  # Routes pour les films populaires et recommandés
  get 'popular', to: 'movies#popular', as: :movies_popular
  get 'recommended', to: 'movies#recommended', as: :movies_recommended

  # Route racine vers la page d'accueil
  root to: 'pages#home'

  # Route pour vérifier l'état de santé de l'application
  get 'up', to: 'rails/health#show', as: :rails_health_check

  # Routes pour les listes et les bookmarks
  resources :lists do
    resources :bookmarks, only: [:new, :create]
  end

  resources :bookmarks, only: [:destroy]
end
