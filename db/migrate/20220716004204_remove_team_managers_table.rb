class RemoveTeamManagersTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :team_managers
  end
end
