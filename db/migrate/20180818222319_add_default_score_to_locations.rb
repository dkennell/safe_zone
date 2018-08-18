class AddDefaultScoreToLocations < ActiveRecord::Migration[5.1]
  def change
    change_column :locations, :score, :integer, default: 50
  end
end
