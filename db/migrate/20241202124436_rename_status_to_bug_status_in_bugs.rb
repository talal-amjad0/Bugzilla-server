class RenameStatusToBugStatusInBugs < ActiveRecord::Migration[7.2]
  def change
    rename_column :bugs, :status, :bug_status
  end
end
