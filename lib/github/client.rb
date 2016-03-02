require 'httparty'

module Github
  class Client

    OAUTH_TOKEN = '9572423dabb85bf5743eac9e0740bb8cdde06959'
    BASE_URI = "https://api.github.com"
    EXCEEDED_RATE_LIMIT_MESSAGE = "API rate limit exceeded for slicksammy."
    # JUST IN CASE WE NEED TO USE THE BELOW
    #client_id = '82d0c52a7b2e7cc63cef'
    #client_secret = '6b31b765d9151cbb8f428ba0d47cef2c08469645'

    def self.get_data
      10.times do
        11.times do
          get_all_public_repos
          get_github_user_data
          get_languages_for_repos
          const_set("OAUTH_TOKEN", 'e19211a17df7bd02c85794b7f738e2a3fc440717')

          get_all_public_repos
          get_github_user_data
          get_languages_for_repos
          const_set("OAUTH_TOKEN", '9572423dabb85bf5743eac9e0740bb8cdde06959')
        end
        sleep 3200
      end
    end

    def self.get_all_public_repos
      uri = "#{BASE_URI}/repositories"
      last = GithubRepo.last.try(:repo_id) || 10_010_000

      uri = "#{uri}?since=#{last}"
      begin
        response = HTTParty.get(uri_with_auth_token(uri))
        parsed = response.parsed_response

        parsed.each do |repo_data|
          save_repo_data(repo_data)
        end
      rescue => ex
        puts "#{ex.backtrace}: #{ex.message} (#{ex.class})"
      end
    end

    def self.get_github_user_data
      GithubUser.last(100).each do |github_user|
        next if github_user.has_data?
        next unless user_name = github_user.user_name

        uri = "#{BASE_URI}/users/#{user_name}"
        begin
          response = HTTParty.get(uri_with_auth_token(uri))
          parsed = response.parsed_response

          save_github_user_data(github_user.id, parsed)
        rescue => ex
          puts "#{ex.backtrace}: #{ex.message} (#{ex.class})"
        end
      end
    end

    def self.get_languages_for_repos
      GithubRepo.last(100).each do |repo|
        next if repo.has_data?

        owner = repo.owner.user_name
        name  = repo.repo_name
        uri   = "#{BASE_URI}/repos/#{owner}/#{name}/languages"
        begin
          response = HTTParty.get(uri_with_auth_token(uri))
          parsed = response.parsed_response

          GithubRepoData.create(github_repo_id: repo.id, languages: parsed)
        rescue => ex
          puts "#{ex.backtrace}: #{ex.message} (#{ex.class})"
        end
      end
    end

=begin
    def self.get_branch_for_repo(branch_name="master")
      GithubRepo.all.each do |repo|
        next if repo.has_branch?(branch_name)

        owner = repo.owner.user_name
        name  = repo.repo_name
        uri   = "#{BASE_URI}/repos/#{owner}/#{name}/branches/#{branch_name}"

        response = HTTParty.get(uri_with_auth_token(uri))
        parsed = response.parsed_response
        parsed.each do |branch_data|
          save_branch_data(repo.id, branch_name)
        end
      end
    end

    def self.get_contributors_for_branch()
      GithubBranch.no_initial_backpop.each do |branch|
        branch_name = branch.name
        repo = branch.github_repo
        owner = repo.owner.user_name
        name = repo.repo_name

        uri   = "#{BASE_URI}/repos/#{owner}/#{name}/branches/#{branch_name}"
        /repos/:owner/:repo/branches/:branch
    end
=end

    private

    def self.save_repo_data(params)
      repo_id = params["id"]
      unless GithubRepo.find_by_repo_id(repo_id)
        repo_name = params["name"]
        repo = GithubRepo.create(repo_id: repo_id, repo_name: repo_name)

        user_data = params["owner"]
        user_id = user_data["id"]
        user_name = user_data["login"]
        GithubUser.create(user_id: user_id, user_name: user_name, owner: true, github_repo_id: repo.id)
      end
    end
=begin
    def self.save_branch_data(repo_id, branch_name, params={})
      unless GithubBranch.find_by_name_and_github_repo_id(name, repo_id)
        GithubBranch.create(name: branch_name, github_repo_id: repo_id)
      end
    end
=end

    def self.save_github_user_data(github_user_id, params)
      unless GithubUserData.find_by_github_user_id(github_user_id)
        if params["location"] && params["email"]
          GithubUserData.create(
            github_user_id: github_user_id,
            name: params["name"],
            location: params["location"],
            email: params["email"],
            hireable: params["hireable"],
            company: params["company"],
            bio: params["bio"],
            public_repos: params["public_repos"],
            followers: params["followers"],
            raw: params,
          )
        end
      end
    end

    def self.uri_with_auth_token(uri)
      "#{uri}?access_token=#{OAUTH_TOKEN}"
    end
  end
end
