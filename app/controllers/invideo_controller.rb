class InvideoController < ApplicationController
  require "uri"
  require "net/http"
  require "json"

  def index
    per_page = 500
    if params[:page].present?
      link = "https://api.invideo.io/get_videos_v2?data="
      param = "%257B%2522noun%2522:%257B%2522word%2522:%2522#{params[:query]}%2522%257D,"
      dimension = "%2522_dimension%2522:%25229:16%2522,"
      allow_copyright = "%2522allow_copyright%2522:false,"
      filter_apis = "%2522filter_apis%2522:%255B%2522pexels%2522,%2522pixabay%2522,%2522istock%2522,%2522storyblock%2522,%2522shutterstock%2522%255D,"
      number_of_videos = "%2522number_of_videos%2522:#{per_page},"
      include_premium = "%2522include_premium%2522:true,"
      timezone = "%2522timezone%2522:%2522Asia/Dhaka%2522,"
      partner = "%2522partner%2522:%2522invideo%2522,"

      # apis_shutterstock_video_count = "%2522apis_video_count%2522:%257B%2522shutterstock%2522:%257B%2522offset%2522:#{params[:shutterstock_offset]},%2522previous_count%2522:#{params[:shutterstock_previous_count]}%257D,"
      # apis_storyblocks_video_count = "%2522storyblocks%2522:%257B%2522offset%2522:#{params[:storyblocks_offset]},%2522previous_count%2522:#{params[:shutterstock_previous_count]}%257D,"
      # apis_pixabay_video_count = "%2522pixabay%2522:%257B%2522offset%2522:#{params[:pixabay_offset]},%2522previous_count%2522:#{params[:pixabay_previous_count]}%257D,"
      # apis_pexels_video_count = "%2522pexels%2522:%257B%2522offset%2522:#{params[:pexels_offset]},%2522previous_count%2522:#{params[:pexels_previous_count]}%257D,"
      # apis_istock_video_count = "%2522istock%2522:%257B%2522offset%2522:#{params[:istock_offset]},%2522previous_count%2522:#{params[:istock_previous_count]}%257D%257D%257D"


      apis_shutterstock_video_count = "%2522apis_video_count%2522:%257B%2522shutterstock%2522:%257B%2522offset%2522:0,%2522previous_count%2522:0%257D,"
      apis_storyblocks_video_count = "%2522storyblocks%2522:%257B%2522offset%2522:0,%2522previous_count%2522:0%257D,"
      apis_pixabay_video_count = "%2522pixabay%2522:%257B%2522offset%2522:0,%2522previous_count%2522:0%257D,"
      apis_pexels_video_count = "%2522pexels%2522:%257B%2522offset%2522:0,%2522previous_count%2522:0%257D,"
      apis_istock_video_count = "%2522istock%2522:%257B%2522offset%2522:#{params[:istock_offset]},%2522previous_count%2522:#{params[:istock_previous_count]}%257D%257D%257D"

      url_string = link + param + dimension + allow_copyright + filter_apis + number_of_videos + include_premium + timezone + partner + apis_shutterstock_video_count + apis_storyblocks_video_count + apis_pixabay_video_count + apis_pexels_video_count + apis_istock_video_count
      url = URI(url_string)
    else
      url_string = "https://api.invideo.io/get_videos_v2?data=%257B%2522noun%2522:%257B%2522word%2522:%2522#{params[:query]}%2522%257D,%2522_dimension%2522:%25229:16%2522,%2522allow_copyright%2522:false,%2522filter_apis%2522:%255B%2522pexels%2522,%2522pixabay%2522,%2522istock%2522,%2522storyblock%2522,%2522shutterstock%2522%255D,%2522number_of_videos%2522:#{per_page},%2522include_premium%2522:true,%2522timezone%2522:%2522Asia/Dhaka%2522,%2522partner%2522:%2522invideo%2522%257D"
      url = URI(url_string)
    end

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["AuthToken"] = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJyb2xlIjpbImFkbWluIl0sImFjY291bnQiOjE5NjUyNTIsInZlcnNpb24iOiIyLjkzLjIiLCJjb25maWciOiJpbnZpZGVvIiwic3ViIjoicmFsZWp5QGNvbmlzb2NpYWwuaXQiLCJpYXQiOjE2MjU1ODI1OTcsImV4cCI6MTY0MTEzNDU5NywidmVyIjoyfQ.1Xu4wIOnbl0Hff_4Gz5hxaDOxmR8vT8IWZFsvt85LQp6HClxzAtvU5SI_duwSDzy77OBoLXxWQ09J4c9c3Ieug"

    response = https.request(request)
    @res = JSON.parse(response.read_body)
    #@videos = @res['videos']

    @videos = []
    @res['videos'].each do |video|
      if video['source'] == 'istock_ESSENTIALS' # 'storyblock' #'shutterstock' #'istock_ESSENTIALS'
        @videos << video
      end
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def download
    url = URI("https://api.invideo.io/v3/get_media_urls_async")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Put.new(url)
    request["Content-Type"] = "application/json"
    request.body = JSON.dump({
                               "master_video_id": " ",
                               "template_id": 19215,
                               "component_id": " ",
                               "media_type": "video",
                               "word": " ",
                               "search_term": " ",
                               "api_type": "ESSENTIALS",
                               "video_link": "#{params[:video_link]}",
                               "thumbnail_link": "#{params[:video_link]}",
                               "partner_video_id": "#{params[:partner_video_id]}",
                               #"source": "istock_ESSENTIALS",
                               #"source": "shutterstock",
                               #"source": "storyblock",
                               "source": "#{params[:source]}",
                               "description": " ",
                               "tags": " ",
                               "video_format": "MP4",
                               "preview_link": "",
                               "thumbnail_time": 0
                             })

    response = https.request(request)
    @res = JSON.parse(response.read_body)
  end
end
