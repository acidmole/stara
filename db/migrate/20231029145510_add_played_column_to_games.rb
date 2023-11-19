class AddPlayedColumnToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :played, :boolean, default: false, not_null: true
  end
end
