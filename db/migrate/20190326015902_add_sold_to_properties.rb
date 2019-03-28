class AddSoldToProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :sold, :boolean, default: false
    add_column :properties, :sold_at, :datetime
  end
end
