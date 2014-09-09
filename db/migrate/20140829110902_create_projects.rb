class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.references :user, index: true
      t.integer :position, default: 0, null: false

      t.timestamps
    end
  end
end
