class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.string :name
      t.text :content
      t.integer :kind
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
