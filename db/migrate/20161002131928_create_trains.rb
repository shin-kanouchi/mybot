class CreateTrains < ActiveRecord::Migration
  def change
    create_table :trains do |t|
      t.integer :user_id
      t.integer :tweet_id
      t.integer :reply_id
      t.integer :topic_id
      t.integer :adequacy_flag, default: 10
      t.integer :choice_count, default: 0
      t.integer :free_b2u_count, default: 0
      t.integer :free_u2b_count, default: 0
      t.timestamps
    end
  end
end
