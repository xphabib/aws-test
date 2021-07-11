class PublicAudioController < ApplicationController
  require "uri"
  require "net/http"

  def index
    offset = params[:offset].present? ? params[:offset] : 0
    limit = params[:limit].present? ? params[:limit] : 20
    url = URI("https://api.invideo.io/music?offset=#{offset}&limit=#{limit}&query=#{params[:query]}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    data = JSON.parse(response.read_body)
    @res = data
  end
end
