class PagesController < ApplicationController
    def home
      @lists = List.all # Remplacez List.all par la logique pour récupérer vos listes
    end
  end
  