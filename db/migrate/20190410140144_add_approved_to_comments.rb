class AddApprovedToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :approved, :boolean, default: false
    add_column :comments, :approved_at, :datetime
    add_reference :comments, :approved_by, foreign_key: { to_table: :users }
  end
end
