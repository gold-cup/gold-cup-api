class CreatePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.date :birthday
      t.string :email
      t.string :gender
      t.string :city
      t.string :province
      t.string :country
      t.string :phone_number
      t.string :type

      t.timestamps
    end
  end
end
