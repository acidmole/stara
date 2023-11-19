class ChangeCompetetionIdAndTeamIdToForeignKeyInStandings < ActiveRecord::Migration[7.0]
  def change
    remove_column :standings, :competition_id
    add_reference :standings, :competition, foreign_key: true
    remove_column :standings, :team_id
    add_reference :standings, :team, foreign_key: true
  end
end
