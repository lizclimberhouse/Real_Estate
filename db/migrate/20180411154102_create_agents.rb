class CreateAgents < ActiveRecord::Migration[5.1]
  def change
    create_table :agents do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :photo

      t.timestamps
    end
  end
end
