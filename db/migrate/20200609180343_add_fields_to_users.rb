class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :country, :string
    add_column :users, :city, :string
    add_column :users, :timezone, :string
    add_column :users, :organization, :string
    add_column :users, :link_website, :string
    add_column :users, :link_youtube, :string
    add_column :users, :link_facebook, :string
    add_column :users, :link_linkedin, :string
    add_column :users, :link_twitter, :string
  end
end
