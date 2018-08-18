class AddCrimeCountsToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :assault_count, :integer, default: 0
    add_column :locations, :shooting_count, :integer, default: 0
    add_column :locations, :rape_count, :integer, default: 0
    add_column :locations, :theft_count, :integer, default: 0
    add_column :locations, :burglary_count, :integer, default: 0
    add_column :locations, :robbery_count, :integer, default: 0
  end
end