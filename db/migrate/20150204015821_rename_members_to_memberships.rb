class RenameMembersToMemberships < ActiveRecord::Migration
  def change
	rename_table :members, :memberships
  end
end
