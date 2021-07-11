class KeywordResearchController < ApplicationController
  require 'net/http'
  require 'open-uri'

  def index
    if params[:query].present?
      query = params[:query].squish.downcase.tr(" ","+")
      uri = URI("https://app.vidiq.com/v0/hottersearch?q=#{query}&im=4.5&group=V5")
      req = Net::HTTP::Get.new(uri)
      req['Authorization'] = ENV['VIDIQ_AUTH']
      res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https', :verify_mode => OpenSSL::SSL::VERIFY_NONE) {|http|
        http.request(req)
      }
      @res = JSON.parse(res.body)
    end
  end
end
