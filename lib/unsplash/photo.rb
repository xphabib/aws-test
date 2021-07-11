class Unsplash::Photo
  require "uri"
  require "net/http"

  def self.search(query="spring", page=1, per_page=30)
    url = URI("https://api.unsplash.com/search/photos?query=#{query}&page=#{page}&per_page=#{per_page}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Authorization"] = ENV['flexclip_unsplash_auth']
    response = https.request(request)
    JSON.parse(response.read_body)
  end
end