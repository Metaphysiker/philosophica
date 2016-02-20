class CreateDateEvents < ActiveRecord::Migration
  def change
    create_table :date_events do |t|
      t.date :date

      t.timestamps null: false
    end
  end
end
