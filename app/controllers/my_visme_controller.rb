class MyVismeController < ApplicationController
  require 'net/http'
  require 'open-uri'
  require "uri"

  def index
    @page = params[:page].present? ? params[:page] : 1
    uri = URI("https://my.visme.co/ajax/searchvideo/#{ENV['MYVISME_URL_CODE']}?keyword=#{params[:query]}&page=#{params[:page]}&perPage=30") if params[:query].present?
    uri = URI("https://my.visme.co/ajax/searchvideo/#{ENV['MYVISME_URL_CODE']}?keyword=&page=#{params[:page]}&perPage=30") unless params[:query].present?
    req = Net::HTTP::Get.new(uri)
    req['cookie'] = ENV['MYVISME_COOKIE']
    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https', :verify_mode => OpenSSL::SSL::VERIFY_NONE) {|http|
      http.request(req)
    }
    @res = JSON.parse(res.body)

    respond_to do |format|
      format.html
      format.json { render json: {res: @res} }
    end
  end

  def download
    url = URI("https://my.visme.co/ajax/uploadStoryBlocksVideoToSproutVideo/#{ENV['MYVISME_URL_CODE']}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request["cookie"] = ENV['MYVISME_COOKIE']
    request["x-csrf-token"] = ENV['MYVISME_X_CSRF_TOKEN']
    form_data = [['videoId', params[:video_id]]]
    request.set_form form_data, 'multipart/form-data'
    response = https.request(request)
    @res = JSON.parse(response.read_body)
    render layout: "download"
  end
end
