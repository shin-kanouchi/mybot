class CreateTrains < ActiveRecord::Migration
  def change
    create_table :trains do |t|
      t.integer :user_id
      t.integer :tweet_id
      t.integer :reply_id
      t.integer :adequacy_flag
      t.timestamps
    end
  end
end
