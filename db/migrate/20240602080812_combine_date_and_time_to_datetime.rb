class CombineDateAndTimeToDatetime < ActiveRecord::Migration[7.0]
  def change
    remove_column :games, :game_day
    remove_column :games, :game_time
    add_column :games, :game_datetime, :datetime
  end
end
