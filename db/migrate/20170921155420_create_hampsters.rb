class CreateHampsters < ActiveRecord::Migration[5.1]
  def change
    create_table :hampsters do |t|
      t.string :name
      t.string :color
      t.integer :victory_points

      t.timestamps
    end
  end
end
