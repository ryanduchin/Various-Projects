class GoalsDefaultPublic < ActiveRecord::Migration
  def change
    remove_column :goals, :private
    add_column :goals, :private, :integer, default: 0
  end
end
