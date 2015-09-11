class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :steamid
      t.string :name
      t.string :avatar

      t.timestamps null: false
    end
  end
end
