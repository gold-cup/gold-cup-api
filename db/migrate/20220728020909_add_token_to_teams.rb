class AddTokenToTeams < ActiveRecord::Migration[6.1]
  def change
    add_column :teams, :password, :string
  end
end
