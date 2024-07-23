class CreateSongs < ActiveRecord::Migration[7.1]
  def change
    create_table :songs do |t|
      t.string :title
      t.string :subtitle
      t.string :artist
      t.text :body

      t.timestamps
    end
  end
end
