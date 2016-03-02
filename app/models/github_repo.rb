class GithubRepo < ActiveRecord::Base

  has_many :github_users
  has_many :github_branches
  has_one  :github_repo_data

  def owner
    self.github_users.owner.last
  end

  def has_branch?(name)
    github_branches.find_by_name(name).present?
  end

  def has_data?
    github_repo_data.present?
  end
end
