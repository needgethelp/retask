class RenameOwnershipsToAssignments < ActiveRecord::Migration
  def self.up
    rename_table :ownerships, :assignments
  end

  def self.down
    rename_table :assignments, :ownerships
  end
end
