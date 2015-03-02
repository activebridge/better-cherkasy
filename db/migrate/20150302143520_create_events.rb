class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :headline
      t.text :description
      t.integer :rating

      t.timestamps
    end
  end
end
