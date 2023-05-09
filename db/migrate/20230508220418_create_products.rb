class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false, unique: true, limit: 100
      t.string :title
      t.decimal :price, null: false, precision: 15, scale: 2, default: 0.0
      t.string :photo, null: false
      t.boolean :state, default: true
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :products, :name
  end
end
