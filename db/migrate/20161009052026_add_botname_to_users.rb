class AddBotnameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :botname, :string
  end
end
