class DropEventsRegions < ActiveRecord::Migration
  def change
    drop_table :events_regions
  end
end
