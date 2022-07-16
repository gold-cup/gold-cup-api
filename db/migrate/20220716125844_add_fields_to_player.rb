class AddFieldsToPlayer < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :division, :string
    add_reference :players, :person, null: false, foreign_key: true
  end
end
