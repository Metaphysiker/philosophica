class ChangeDefault < ActiveRecord::Migration
  def change
    change_column_default :users, :blogrole,"regular"
  end
end
