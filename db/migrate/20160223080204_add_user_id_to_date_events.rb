class AddUserIdToDateEvents < ActiveRecord::Migration
  def change
    add_column :date_events, :user_id, :integer
  end
end
