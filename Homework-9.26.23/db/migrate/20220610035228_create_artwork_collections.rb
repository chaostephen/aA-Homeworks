class CreateArtworkCollections < ActiveRecord::Migration[7.0]
  def change
    create_table :artwork_collections do |t|
      t.references :collection, null: false, foreign_key: true, index: false
      t.references :artwork, null: false, foreign_key: true

      t.timestamps
    end
    add_index :artwork_collections, [:collection_id, :artwork_id], unique: true
  end
end
