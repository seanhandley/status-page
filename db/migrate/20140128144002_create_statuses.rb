class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :name
      t.string :colour
      t.boolean :resolved

      t.timestamps
    end
  end
end
