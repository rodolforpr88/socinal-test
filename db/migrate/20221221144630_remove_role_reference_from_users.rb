class RemoveRoleReferenceFromUsers < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    safety_assured { remove_reference :users, :role, foreign_key: true, index: false }
  end
end
