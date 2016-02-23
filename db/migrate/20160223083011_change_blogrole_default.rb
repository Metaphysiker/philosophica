class ChangeBlogroleDefault < ActiveRecord::Migration
  def change
    change_column_default :users, :blogrole, default: "regular"
  end
end
