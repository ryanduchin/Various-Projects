class AddCompletedToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :completed, :integer, default: 0
  end
end
