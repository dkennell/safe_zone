class AddPolygonToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :polygon, :text
  end
end
