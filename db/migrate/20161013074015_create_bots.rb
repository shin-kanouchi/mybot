class CreateBots < ActiveRecord::Migration
  def change
    create_table :bots do |t|
      t.integer  :user_id
      t.text     :bot_name
      t.integer  :gender
      t.integer  :bot_rank, default: 0
      t.integer  :battle_point, default: 0
      t.integer  :hair_color
      t.timestamps 
    end
  end
end
