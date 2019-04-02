class AddApprovedToProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :approved, :boolean, default: false
    add_column :properties, :approved_at, :datetime
    add_reference :properties, :approved_by, foreign_key: { to_table: :users }
  end
end
