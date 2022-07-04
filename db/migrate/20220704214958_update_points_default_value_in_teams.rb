class UpdatePointsDefaultValueInTeams < ActiveRecord::Migration[6.1]
  def change
    change_column_default :teams, :points, from: nil, to: 0
  end
end
