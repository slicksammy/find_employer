class CreateGithubUsersData < ActiveRecord::Migration
  def change
    create_table :github_user_data do |t|

      t.integer :github_user_id
      t.string  :name
      t.string  :location
      t.string  :email
      t.boolean :hireable
      t.string  :company
      t.string  :bio
      t.integer :followers
      t.integer :public_repos
      t.json    :raw

      t.timestamps
    end
  end
end
