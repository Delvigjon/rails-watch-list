class AddBackgroundImageUrlToLists < ActiveRecord::Migration[7.1]
  def change
    add_column :lists, :background_image_url, :string
  end
end
