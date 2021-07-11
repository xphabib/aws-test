class ShutterstockVideosController < ApplicationController
  require 'net/http'
  require 'open-uri'

  def index
    @page = params[:page].present? ? params[:page] : 1
    if params[:query].present?
      uri = URI("https://api.ripl.com/stock_media/search/videos.json?auth_token=Yiim7WgHst4LFXPmucyL&page=#{@page}&query=#{params[:query]}")
    else
      uri = URI("https://api.ripl.com/stock_media/search/videos.json?auth_token=Yiim7WgHst4LFXPmucyL&page=#{@page}")
    end
    
    res = Net::HTTP.get_response(uri)
    @res = JSON.parse(res.body)

    respond_to do |format|
      format.html
      format.json { render json: {res: @res} }
    end
  end

  def details
    uri = URI("https://api.ripl.com/stock_media/video.json?auth_token=Yiim7WgHst4LFXPmucyL&external_media_id=#{params[:media]}")
    res = Net::HTTP.get_response(uri)
    @res = JSON.parse(res.body)
    render layout: "download"
  end
end
