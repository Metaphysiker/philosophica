class AddEventIdToDateevents < ActiveRecord::Migration
  def change
    add_column :date_events, :event_id, :integer
  end
end
