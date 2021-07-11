class PublicPhotosController < ApplicationController
  require "uri"
  require "json"
  require "net/http"

  def index
    query = params[:query].present? ? params[:query] : 'spring'
    page = params[:page].present? ? params[:page] : 1
    url = URI("https://animoto.com/appservice/asset_library/stock/search")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request["x-animoto-authorization"] = ENV['X_ANIMOTO_AUTHORIZATION']
    request["x-animoto-accept"] = "application/vnd.animoto-v5+json"
    request["Content-Type"] = "application/json"
    request.body = JSON.dump({
                               "stock_search": {
                                 "query": "#{query}",
                                 "media_type": "images",
                                 "page": page,
                                 "page_size": 100,
                                 "graphical_styles_filter_type": "include",
                                 "graphical_styles": "photography"
                               }
                             })

    response = https.request(request)
    data = JSON.parse(response.read_body)
    @res = data['response']['payload']['stock_search']['results']
  end

  def unsplash
    page = params[:page].present? ? params[:page] : 1
    query = params[:query].present? ? params[:query] : 'spring'
    data = Unsplash::Photo.search(query, page, 30)
    @res = data['results']
  end
end
