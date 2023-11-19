class CreateResults < ActiveRecord::Migration[7.0]
  def change
    create_table :results do |t|
      t.references :game, foreign_key_column_for: :games
      t.integer :home_team_score
      t.integer :away_team_score

      t.timestamps
    end
  end
end
