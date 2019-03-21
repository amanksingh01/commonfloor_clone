class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.references :property, foreign_key: true
      t.text :comment
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :comments, [:property_id, :created_at]
  end
end
