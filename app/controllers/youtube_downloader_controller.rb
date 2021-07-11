class YoutubeDownloaderController < ApplicationController
  require "active_support/all"
  require 'net/http'
  require 'uri'
  require 'json'

  def index
    if params[:youtube_url].present?
      url = "https://api.fastfrom.com/download"
      request_params =  {
        url: params[:youtube_url],
        lang: "en"
      }
      request_header = { 'Content-Type': 'application/json' }
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Post.new(uri.path, request_header)
      request.body = request_params.to_json
      http.request(request)
      response = http.request(request)
      @res = JSON.parse(response.body)
    end
  end
end
