class CreateIdentities < ActiveRecord::Migration[5.2]
  def change
    create_table :identities do |t|
      t.references :user, foreign_key: true
      t.string :uid
      t.string :provider

      t.timestamps
    end
    add_index :identities, [:uid, :provider], unique: true
  end
end
