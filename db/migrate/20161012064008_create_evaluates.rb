class CreateEvaluates < ActiveRecord::Migration
  def change
    create_table :evaluates do |t|

      t.integer :evaluator
      t.integer :user_x_id
      t.integer :user_y_id

      t.timestamps
    end
  end
end
