class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :avatar_url
      t.string :provider
      t.string :providerid

      t.timestamps
    end
  end
end
