class AddUserAssociationToTeam < ActiveRecord::Migration[6.1]
  def change
    add_reference :teams, :manager, null: false, foreign_key: { to_table: :users }
  end
end
