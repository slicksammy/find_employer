class GithubUser < ActiveRecord::Base

  belongs_to :github_repo
  has_one :github_user_data

  scope :owner, -> { where(owner:true) }

  def has_data?
    github_user_data.present?
  end
  
end
