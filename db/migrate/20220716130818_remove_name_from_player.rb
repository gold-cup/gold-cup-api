class RemoveNameFromPlayer < ActiveRecord::Migration[6.1]
  def change
    remove_column :players, :name, :string
  end
end
