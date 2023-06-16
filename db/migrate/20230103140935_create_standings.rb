class CreateStandings < ActiveRecord::Migration[7.0]
  def change
    create_table :standings do |t|
      t.integer :competition_id
      t.integer :team_id
      t.integer :games
      t.integer :wins
      t.integer :losses
      t.integer :scored_for
      t.integer :scored_against
      t.integer :points

      t.timestamps
    end
  end
end
