class List < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    has_many :bookmarks
    has_many :movies, through: :bookmarks
    before_destroy :destroy_associated_movies

  private

  # Method to destroy associated movies
  def destroy_associated_movies
    self.movies.destroy_all
  end
end
