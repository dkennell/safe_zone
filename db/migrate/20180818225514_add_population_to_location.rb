class AddPopulationToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :population, :integer
  end
end
