class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :liker, null: false, foreign_key: { to_table: :users }, index: false
      t.references :likeable, polymorphic: true, null: false

      t.timestamps
    end

    add_index :likes, [:liker_id, :likeable_type, :likeable_id], unique: true
  end
end
