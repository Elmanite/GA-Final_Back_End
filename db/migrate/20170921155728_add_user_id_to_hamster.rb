class AddUserIdToHamster < ActiveRecord::Migration[5.1]
  def change
    add_column :hamsters, :user_id, :integer
  end
end
