class AddLatLngToEvents < ActiveRecord::Migration
  def change
    add_column :events, :lat, :float
    add_column :events, :lng, :float
    add_column :events, :address, :string
  end
end
