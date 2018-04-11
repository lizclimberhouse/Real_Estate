class CreateBuyers < ActiveRecord::Migration[5.1]
  def change
    create_table :buyers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.float :max_price
      t.text :cities
      t.belongs_to :agent, foreign_key: true

      t.timestamps
    end
  end
end
