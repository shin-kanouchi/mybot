class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.integer  :source_flag
      t.integer  :topic_id
      t.text     :sentence
      t.text     :nouns
      t.integer  :bad_q_count, default: 0
      t.timestamps
    end
  end
end
