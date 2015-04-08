class CreateEventsRegions < ActiveRecord::Migration
  def change
    create_table :events_regions, id: false do |t|
      t.belongs_to :event, index: true
      t.belongs_to :region, index: true
    end
  end
end
