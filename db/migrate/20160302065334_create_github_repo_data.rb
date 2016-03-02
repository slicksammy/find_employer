class CreateGithubRepoData < ActiveRecord::Migration
  def change
    create_table :github_repo_data do |t|
      t.integer :github_repo_id
      t.json :languages

      t.timestamps
    end
  end
end
