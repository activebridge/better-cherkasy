class AddCommentsCountToEvents < ActiveRecord::Migration
  def up
    add_column :events, :comments_count, :integer
    Event.reset_column_information
    Event.find_each do |event|
      Event.update_counters event.id, comments_count: event.comments.count
    end
  end

  def down
    remove_column :events, :comments_count
  end
end
