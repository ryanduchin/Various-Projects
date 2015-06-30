class AddAuthorIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :author_id, :integer
    add_index :comments, :author_id
  end
end
