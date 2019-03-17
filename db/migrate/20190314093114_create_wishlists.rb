class CreateWishlists < ActiveRecord::Migration[5.1]
  def change
    create_table :wishlists do |t|
      t.references :user, foreign_key: true
      t.references :property, foreign_key: true

      t.timestamps
    end
    add_index :wishlists, [:user_id, :property_id], unique: true
  end
end
