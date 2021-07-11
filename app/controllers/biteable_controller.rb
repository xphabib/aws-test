class BiteableController < ApplicationController
  require 'net/http'
  require 'open-uri'

  def index
    @page = params[:page].present? ? params[:page] : 1
    uri = URI("https://api.biteable.com/zymbol-footage?page=#{@page}&per_page=24&project_id=4005779&query=#{params[:query]}&type=video-blocks") if params[:query].present?
    uri = URI("https://api.biteable.com/zymbol-footage?page=#{@page}&per_page=30&project_id=4005779&type=video-blocks") unless params[:query].present?
    res = Net::HTTP.get_response(uri)
    @res = JSON.parse(res.body)
  end

  def photos
    @page = params[:page].present? ? params[:page] : 1
    uri = URI("https://api.unsplash.com/search/photos?query=#{params[:query]}&page=#{@page}&per_page=30") if params[:query].present?
    uri = URI("https://api.unsplash.com/search/photos?query=nature&page=#{@page}&per_page=30") unless params[:query].present?
    req = Net::HTTP::Get.new(uri)
    req['authorization'] = ENV['BITEABLE_AUTH']
    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https', :verify_mode => OpenSSL::SSL::VERIFY_NONE) {|http|
      http.request(req)
    }
    @res = JSON.parse(res.body)
  end

end
