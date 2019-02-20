class AddIndexToPropertiesCreatedAt < ActiveRecord::Migration[5.1]
  def change
    add_index :properties, :created_at
  end
end
