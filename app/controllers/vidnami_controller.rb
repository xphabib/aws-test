class VidnamiController < ApplicationController
  require 'net/http'
  require 'open-uri'

  def index
    @per_page = params[:per_page].present? ? params[:per_page] : 0
    uri = URI("https://media.contentsamurai.com/search/videos?storyblocks=#{@per_page}&usage=pd,by,sa,nc&video=2227288&word=#{params[:query]}") if params[:query].present?
    uri = URI("https://media.contentsamurai.com/search/videos?storyblocks=#{@per_page}&usage=pd,by,sa,nc&video=2227288&word=nobody") unless params[:query].present?
    req = Net::HTTP::Get.new(uri)
    req['Authorization'] = ENV['VIDNAMI_AUTH']
    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https', :verify_mode => OpenSSL::SSL::VERIFY_NONE) {|http|
      http.request(req)
    }
    @res = JSON.parse(res.body)
  end

  def download
    path = params[:video_url]

    IO.copy_stream(
      open(
        path,
        ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE
      ),
      'test.csv'
    )
  end

  def vidnami_token
    token = params[:token]
    vidnami_token = VidnamiAuth.first
    if vidnami_token.present?
      vidnami_token.update(token: token)
    else
      VidnamiAuth.create(token: token)
    end
    redirect_to root_url
  end
end
