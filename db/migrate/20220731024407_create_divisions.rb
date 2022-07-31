class CreateDivisions < ActiveRecord::Migration[6.1]
  def change
    create_table :divisions do |t|
      t.string :code
      t.string :name
      t.date :min_date
      t.date :max_date

      t.timestamps
    end
  end
end
