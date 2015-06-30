class AddVotesToUrls < ActiveRecord::Migration
  def change
    add_column :shortened_urls, :votes, :integer, default: 0, null: false
  end
end
