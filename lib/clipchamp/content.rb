class Clipchamp::Content
  require "uri"
  require "json"
  require "net/http"

  def self.videos(query, page)
    query = "nature" unless query.present?
    page = 0 unless page.present?
    skip = 50 * page
    url = URI("https://content-repo.clipchamp.com/v1/content/search")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request["x-content-repo-api-key"] = ENV['clipchamp_x_content_repo_api_key']
    request["Content-Type"] = "application/json"
    request.body = JSON.dump({
                               "q": query,
                               "skip": skip,
                               "filters": [
                                 {
                                   "type": "eq",
                                   "field": "type",
                                   "value": "video"
                                 },
                                 {
                                   "type": "eq",
                                   "field": "locale",
                                   "value": "en"
                                 }
                               ],
                               "limit": 50,
                               "sorts": []
                             })

    response = https.request(request)
    JSON.parse(response.read_body)
  end

  def self.related_video(id)
    url = URI("https://content-repo.clipchamp.com/v1/content/related/#{id}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["x-content-repo-api-key"] = ENV['clipchamp_x_content_repo_api_key']
    request["Content-Type"] = "application/json"
    request.body = JSON.dump({
                               "types": [
                                 "video"
                               ],
                               "limit": 8
                             })

    response = https.request(request)
    JSON.parse(response.read_body)
  end

  def self.download(vid)
    url = URI("https://app.clipchamp.com/v2/stock-items/video/download/#{vid}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Authorization"] = ENV['clipchamp_authorization']
    response = https.request(request)
    JSON.parse(response.read_body)
  end
end