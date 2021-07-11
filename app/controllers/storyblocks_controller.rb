class StoryblocksController < ApplicationController
  require 'net/http'
  require 'open-uri'

  def index
    @page = params[:page].present? ? params[:page] : 1
    uri = URI("https://qpr75670gd.execute-api.us-east-1.amazonaws.com/production/v2/search/video?content_type=footage%2Cmotionbackgrounds&keywords=#{params[:query]}&page=#{@page}&project_id=316140&results_per_page=20&user_id=13407603")
    res = Net::HTTP.get_response(uri)
    @res = JSON.parse(res.body)
  end

  def photos
    @page = params[:page].present? ? params[:page] : 1
    uri = URI("https://qpr75670gd.execute-api.us-east-1.amazonaws.com/production/v2/search/images?content_type=photos&keywords=#{params[:query]}&page=#{@page}&project_id=316140&results_per_page=20&user_id=13407603")
    res = Net::HTTP.get_response(uri)
    @res = JSON.parse(res.body)
  end
end
