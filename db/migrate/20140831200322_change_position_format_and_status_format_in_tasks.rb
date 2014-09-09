class ChangePositionFormatAndStatusFormatInTasks < ActiveRecord::Migration
  def change
    change_column :tasks, :position, :integer
    change_column :tasks, :status, :integer
  end
end
