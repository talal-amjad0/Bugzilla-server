class CreateJwtRevocations < ActiveRecord::Migration[7.2]
  def change
    create_table :jwt_revocations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :jti

      t.timestamps
    end
    add_index :jwt_revocations, :jti
  end
end
