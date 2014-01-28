class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :status
      t.string :title
      t.text :content
      t.datetime :event_date
      t.datetime :updated_at
      t.datetime :resolved_at
      t.boolean :resolved
      t.integer :status_id

      t.timestamps
    end
  end
end
