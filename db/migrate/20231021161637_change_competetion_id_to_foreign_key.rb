class ChangeCompetetionIdToForeignKey < ActiveRecord::Migration[7.0]
  def change
    remove_column :games, :competition_id
    add_reference :games, :competition, foreign_key: true

  end
end
