class RemoveRatingFromEvents < ActiveRecord::Migration
  def up
    remove_column :events, :rating
  end

  def down
    add_column :events, :rating, :integer, default: 0
  end
end
