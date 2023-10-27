class ChangeTeamIdsToForeignKeysInGames < ActiveRecord::Migration[7.0]
  def change
    remove_column :games, :home_team_id
    remove_column :games, :away_team_id
    add_reference :games, :home_team, foreign_key: { to_table: :teams }
    add_reference :games, :away_team, foreign_key: { to_table: :teams }
  end
end
