class AddCrimeCountsToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :assault_count, :integer
    add_column :locations, :shooting_count, :integer
    add_column :locations, :rape_count, :integer
    add_column :locations, :theft_count, :integer
    add_column :locations, :burglary, :integer
    add_column :locations, :robbery, :integer
  end
end
