class CreateGithubUsers < ActiveRecord::Migration
  def change
    create_table :github_users do |t|
      t.integer :user_id
      t.string  :user_name
      t.integer :github_repo_id
      t.boolean :owner

      t.timestamps
    end
  end
end
