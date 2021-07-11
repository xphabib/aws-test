class ShutterstockPhotosController < ApplicationController
  require 'net/http'
  require 'open-uri'

  def index
    @page = params[:page].present? ? params[:page] : 1
    if params[:query].present?
      uri = URI("https://api.ripl.com/stock_media/search/photos.json?auth_token=Yiim7WgHst4LFXPmucyL&page=#{@page}&query=#{params[:query]}")
    else
      uri = URI("https://api.ripl.com/stock_media/search/photos.json?auth_token=Yiim7WgHst4LFXPmucyL&page=#{@page}")
    end
    
    res = Net::HTTP.get_response(uri)
    @res = JSON.parse(res.body)
  end


  def details
    uri = URI("https://api.ripl.com/stock_media/photo.json?auth_token=Yiim7WgHst4LFXPmucyL&external_media_id=#{params[:media]}&search_id=#{params[:search_id]}")
    res = Net::HTTP.get_response(uri)
    @res = JSON.parse(res.body)
  end
end
