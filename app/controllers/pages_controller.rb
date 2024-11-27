class PagesController < ApplicationController
    def home
      @lists = List.all # Remplacez List.all par la logique pour récupérer vos listes
    end
    def contact
      # Logique pour la page de contact (optionnelle)
    end
end
  