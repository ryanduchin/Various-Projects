class AddPrivateToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :private, :boolean, default: false
    add_index :goals, :title
  end
end
