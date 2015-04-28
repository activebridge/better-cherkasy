class AddVisitsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :visits, :integer, default: 0
  end
end
