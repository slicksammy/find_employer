class CreateGithubRepos < ActiveRecord::Migration
  def change
    create_table :github_repos do |t|
      t.integer :repo_id
      t.string  :repo_name

      t.timestamps
    end
  end
end
