class PowtonController < ApplicationController
  require "uri"
  require "json"
  require "net/http"

  def index
    blocks_type = params[:blocks_type].present? ? params[:blocks_type] : 'storyblocks'
    @page = params[:page].present? ? params[:page] : 1
    url = URI("https://powtoon-api-1.global.ssl.fastly.net/api/v2/media-catalog/providers/#{blocks_type}?search=#{params[:query]}&page_size=99&page=#{@page}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    @res = JSON.parse(response.read_body)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def download
    blocks_type = params[:blocks_type].present? ? params[:blocks_type] : 'storyblocks'
    url = URI("https://www.powtoon.com/api/v2/media-catalog/providers/#{blocks_type}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request["x-csrftoken"] = ENV['POWTON_X_CSRFTOKEN']
    request["cookie"] = ENV['POWTON_COOKIE']
    request["referer"] = ENV['POWTON_REFERER']
    request["Content-Type"] = "application/json"
    request.body = JSON.dump({
                               "provider_id": params[:video_info][:provider_id],
                               "width": params[:video_info][:width],
                               "height": params[:video_info][:height],
                               "item_type": params[:video_info][:item_type],
                               "file_format": params[:video_info][:file_format],
                               "thumb_url": params[:video_info][:thumb_url],
                               "preview_url": params[:video_info][:preview_url],
                               "file_url": params[:video_info][:file_url],
                               "name": params[:video_info][:name],
                               "description": params[:video_info][:description],
                               "license_level": params[:video_info][:license_level],
                               "families": params[:video_info][:families],
                               "duration": 10,
                               "video_data": {
                                 "original_duration": 10,
                                 "duration": 10,
                                 "video_files": {
                                   "preview": params[:video_info][:video_data][:video_files][:preview]
                                 }
                               },
                               "provider": params[:video_info][:provider],
                               "item_name": params[:video_info][:item_name],
                               "items_name": params[:video_info][:items_name],
                               "id": params[:video_info][:id]
                             })

    response = https.request(request)
    @res = JSON.parse(response.read_body)
    render layout: "download"
  end

  private
  def video_params
    params.require(:video_info).permit!
  end
end
