# encoding: utf-8

class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :headline
      t.text :description
      t.integer :rating, default: 0

      t.timestamps
    end
  end
end
