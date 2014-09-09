class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.references :project, index: true
      t.references :user, index: true
      t.decimal :position, default: 0, null: false
      t.decimal :status

      t.timestamps
    end
  end
end
