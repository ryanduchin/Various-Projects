class ChangeShortenedUrlsAndVisits < ActiveRecord::Migration
  def change
    change_column :shortened_urls, :short_url, :string, null: false
    change_column :shortened_urls, :long_url, :string, null: false
    change_column :shortened_urls, :submitter_id, :integer, null: false

    change_column :visits, :shortened_url_id, :integer, null: false
    change_column :visits, :visitor_id, :integer, null: false
  end
end
