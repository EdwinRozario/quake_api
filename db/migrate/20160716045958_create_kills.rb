class CreateKills < ActiveRecord::Migration[5.0]
  def change
    create_table :kills do |t|
      t.integer :killer_id
      t.integer :victim_id
      t.integer :game_id
      t.string :method

      t.timestamps
    end
  end
end
