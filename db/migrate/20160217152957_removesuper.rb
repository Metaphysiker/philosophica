class Removesuper < ActiveRecord::Migration
  def change
    remove_column :users, :superadmin
  end
end
