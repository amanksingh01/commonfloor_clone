class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|
      t.references :user, foreign_key: true
      t.string :owner_name
      t.string :property_type
      t.string :property_status
      t.string :bed_rooms
      t.string :area
      t.string :price
      t.string :street_address
      t.string :locality
      t.string :city
      t.string :state
      t.string :pincode
      t.string :country

      t.timestamps
    end
    add_index :properties, :property_type
    add_index :properties, :property_status
    add_index :properties, :bed_rooms
    add_index :properties, :area
    add_index :properties, :price
    add_index :properties, :locality
    add_index :properties, :city
  end
end
