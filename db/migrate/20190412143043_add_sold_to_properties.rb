class AddSoldToProperties < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :sold, :boolean, default: false
    add_column :properties, :sold_at, :datetime
    add_reference :properties, :buyer, foreign_key: { to_table: :users }
  end
end
