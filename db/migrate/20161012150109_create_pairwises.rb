class CreatePairwises < ActiveRecord::Migration
  def change
    create_table :pairwises do |t|
      t.integer :evaluate_id
      t.integer :user_id
      t.integer :tweet_id
      t.integer :reply_x_id
      t.integer :reply_y_id
      t.integer :inequality_flag
      t.timestamps
    end
  end
end
