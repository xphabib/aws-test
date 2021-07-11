class WevideoController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'
  def index
    type = 'video'
    if params[:type].present?
      type = params[:type]
    end

    keywords = 'nature'

    if params[:query].present?
      keywords = params[:query]
    end

    @page = 1

    if params[:page].present?
      @page = params[:page]
    end

    url = URI.parse('https://www.wevideo.com/api/3/content/storyblocks/search')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    data = {mediaType: type, keywords: keywords, num_results: 50, page: @page}
    request = Net::HTTP::Post.new(url.path, {'Content-Type' => 'application/json'})
    request.body = data.to_json
    response = http.request(request)
    @res = JSON.parse(response.body)

    respond_to do |format|
      format.html
      format.json { render json: {res: @res} }
    end
  end
end
