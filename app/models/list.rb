class List < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :list_movies
  has_many :movies, through: :list_movies
  has_many :bookmarks
  
  # Si bookmarks est utilisé comme favoris, sinon supprime cette ligne :
  # has_many :movies, through: :bookmarks

  before_destroy :destroy_associated_movies

  has_one_attached :photo

  private

  def destroy_associated_movies
    # Supprime la relation, mais ne détruit pas les films eux-mêmes
    self.list_movies.delete_all
  end
end
