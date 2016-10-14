class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.text     :sentence
      t.integer  :source_flag
      t.timestamps
    end
  end
end
