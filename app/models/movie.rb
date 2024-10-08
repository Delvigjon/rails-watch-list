class Movie < ApplicationRecord
  has_many :list_movies
  has_many :lists, through: :list_movies
  has_many :bookmarks

  validates :title, presence: true
  validates :overview, presence: true
  validates :poster_url, presence: true
  validates :rating, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
end
