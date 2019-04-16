class CreateVisitors < ActiveRecord::Migration[5.2]
  def change
    create_table :visitors do |t|
      t.string :remote_ip

      t.timestamps
    end
    add_index :visitors, :remote_ip, unique: true
  end
end
