class RemoveBooleanFromGoals < ActiveRecord::Migration
  def change
    remove_column :goals, :private
    add_column :goals, :private, :integer
  end
end
