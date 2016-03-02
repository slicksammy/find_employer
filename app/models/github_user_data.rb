class GithubUserData < ActiveRecord::Base

  belongs_to :github_user

  US_CITIES = YAML.load_file("config/top_100_cities.yml")
  
  def in_us?
    US_CITIES.any? { |city| location.downcase.include?(city.downcase) }
  end

  def in_city?(city)
    location.downcase.include?(city.downcase)
  end

end
