class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :appid
      t.string :name
      t.string :img_logo_url
      t.integer :population

      t.timestamps null: false
    end
  end
end
