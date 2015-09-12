class CreatePlaytimes < ActiveRecord::Migration
  def change
    create_table :playtimes do |t|
      t.references :player, index: true, foreign_key: true
      t.references :game, index: true, foreign_key: true
      t.string :playtime_total

      t.timestamps null: false
    end
  end
end
