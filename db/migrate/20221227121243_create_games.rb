class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.integer :game_id
      t.date :game_day
      t.time :game_time
      t.string :home_team
      t.string :away_team

      t.timestamps
    end
  end
end
