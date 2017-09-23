class AddUserIdToHampster < ActiveRecord::Migration[5.1]
  def change
    add_column :hampsters, :user_id, :integer
  end
end
