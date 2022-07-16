class RemoveTypeFromPerson < ActiveRecord::Migration[6.1]
  def change
    remove_column :people, :type, :string
  end
end
