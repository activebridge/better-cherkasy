class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :title

      t.timestamps
    end
  end
end
