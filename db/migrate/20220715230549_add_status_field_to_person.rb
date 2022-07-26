class AddStatusFieldToPerson < ActiveRecord::Migration[6.1]
  def change
    add_column :people, :status, :string
  end
end
