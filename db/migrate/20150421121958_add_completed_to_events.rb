class AddCompletedToEvents < ActiveRecord::Migration
  def change
    add_column :events, :completed, :boolean
  end
end
