class RemoveNullRequirementFromPlayer < ActiveRecord::Migration[6.1]
  def up
    change_column :players, :team_id, :bigint, null: true
  end

  def down
    change_column :players, :team_id, :bigint, null: false
  end
end
