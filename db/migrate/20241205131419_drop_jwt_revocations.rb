class DropJwtRevocations < ActiveRecord::Migration[7.2]
  def change
    drop_table :jwt_revocations
  end
end
