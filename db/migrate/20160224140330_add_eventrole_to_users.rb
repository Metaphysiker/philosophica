class AddEventroleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :eventrole, :string, default: "regular"
  end
end
