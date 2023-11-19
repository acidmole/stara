class AddActiveColumnToCompetition < ActiveRecord::Migration[7.0]
  def change
    add_column :competitions, :active, :boolean, default: true, not_null: true
  end
end
