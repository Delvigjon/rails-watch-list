class RemoveUrlFromMovies < ActiveRecord::Migration[7.1]
  def change
    remove_column :movies, :url
  end
end
