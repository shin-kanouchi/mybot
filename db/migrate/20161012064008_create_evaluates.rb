class CreateEvaluates < ActiveRecord::Migration
  def change
    create_table :evaluates do |t|

      t.integer :evaluator
      t.integer :user_x_id
      t.integer :user_y_id
      t.integer :topic_id
      t.integer :win_flag, default: 3
      t.integer :state_flag, default: 0
      t.timestamps
    end
  end
end
