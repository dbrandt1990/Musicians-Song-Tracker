class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs  do  |t|
      t.string :name 
      t.string :video
      t.string :tabs
      t.integer :user_id
    end
  end
end
