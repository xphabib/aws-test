class JumpstoryController < ApplicationController
  require 'net/http'
  require 'open-uri'

  def index
    @page = params[:page].present? ? params[:page] : 1
    if params[:query].present?
      uri = URI("https://vidair-api.wondershare.com/resource/search?platform=2&type=5&pageNum=#{@page}&pageSize=50&keyword=#{params[:query]}")
    else
      uri = URI("https://vidair-api.wondershare.com/resource/search/default?pageNum=#{@page}&pageSize=50&platform=2&projectID=0&templateID=0&type=5")
    end
    res = Net::HTTP.get_response(uri)
    @res = JSON.parse(res.body)
  end

  def photos
    @page = params[:page].present? ? params[:page] : 1
    if params[:query].present?
      uri = URI("https://vidair-api.wondershare.com/resource/search?platform=2&type=3&pageNum=#{@page}&pageSize=50&keyword=#{params[:query]}")
    else
      uri = URI("https://vidair-api.wondershare.com/resource/search/default?pageNum=#{@page}&pageSize=50&platform=2&templateID=0&projectID=0&type=3")
    end
    res = Net::HTTP.get_response(uri)
    @res = JSON.parse(res.body)
  end
end
