class CreateEventUsers < ActiveRecord::Migration
  def change
    create_table :event_users do |t|
      t.integer :user_id
      t.integer :event_id
      t.boolean :liked

      t.timestamps
    end
  end
end
