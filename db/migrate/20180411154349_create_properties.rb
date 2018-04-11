class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|
      t.float :price
      t.boolean :sold
      t.float :sold_price
      t.integer :beds
      t.integer :baths
      t.integer :sq_ft
      t.belongs_to :agent, foreign_key: true

      t.timestamps
    end
  end
end
