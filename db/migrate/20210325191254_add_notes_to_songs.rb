class AddNotesToSongs < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :notes, :text
  end
end
