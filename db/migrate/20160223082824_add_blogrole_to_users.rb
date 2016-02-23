class AddBlogroleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :blogrole, :string
  end
end
