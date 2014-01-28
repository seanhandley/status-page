class RemoveResolvedFromStatus < ActiveRecord::Migration
  def change
    remove_column :statuses, :resolved, :boolean
  end
end
