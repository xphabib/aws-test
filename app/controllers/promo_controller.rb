class PromoController < ApplicationController
  require "uri"
  require "net/http"

  def index
    page = params[:page].present? ? params[:page] : 1
    url = URI("https://promo.com/promoVideos/data/search?keyword=#{params[:query]}&page=#{page}&sort_order=best_match&type=all&limit=80")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    @res = JSON.parse(response.body)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def photos
    page = params[:page].present? ? params[:page] : 1
    url = URI("https://promo.com/promoVideos/data/search-photos?page=#{page}&limit=20&keyword=#{params[:query]}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    @res = JSON.parse(response.body)
    respond_to do |format|
      format.html
      format.js
    end

  end
end
