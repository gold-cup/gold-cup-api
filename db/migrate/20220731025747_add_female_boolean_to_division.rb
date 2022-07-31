class AddFemaleBooleanToDivision < ActiveRecord::Migration[6.1]
  def change
    add_column :divisions, :female_only, :boolean
  end
end
