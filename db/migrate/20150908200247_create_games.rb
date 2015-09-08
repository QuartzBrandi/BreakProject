class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.integer :population

      t.timestamps null: false
    end
  end
end
