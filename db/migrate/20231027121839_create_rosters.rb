class CreateRosters < ActiveRecord::Migration[7.0]
  def change
    create_table :rosters do |t|

      t.integer :team_id, null: false, foreign_key_column_for: :teams
      t.string :players
      t.timestamps
    end
  end
end
