class AddParentEmailToPerson < ActiveRecord::Migration[6.1]
  def change
    add_column :people, :parent_email, :string
  end
end
