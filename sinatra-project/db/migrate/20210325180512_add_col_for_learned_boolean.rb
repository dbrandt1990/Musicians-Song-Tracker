class AddColForLearnedBoolean < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :learned, :boolean
  end
end
