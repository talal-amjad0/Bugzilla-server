class CreateBugs < ActiveRecord::Migration[7.2]
  def change
    create_table :bugs do |t|
      t.string :title
      t.text :description
      t.integer :type
      t.integer :status
      t.string :image
      t.datetime :deadline
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.references :assignee, null: false, foreign_key: { to_table: :users }
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
