class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
        t.string  :title
        t.integer :year
        t.integer :band_id
        t.boolean :studio, default: true

    end
      add_index :albums, :band_id
  end
end
