class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :comment
      t.string :added_by
      t.integer :event_id

      t.timestamps
    end
  end
end
