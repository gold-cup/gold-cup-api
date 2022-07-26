class AddPermissionFieldToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :permission, :string, default: "user"
  end
end
