class UbersuggestController < ApplicationController
  def index
    if params[:query].present?
      key = params[:next_key].present? ? params[:next_key] : 0
      uri = URI("https://app.neilpatel.com/api/match_keywords?keyword=#{params[:query]}&locId=2840&language=en&sortBy=searchVolume&sortMode=desc&limit=40&previousKey=#{key}")
      req = Net::HTTP::Get.new(uri)
      req['Authorization'] = ENV['UBERSUGGEST_AUTH']
      res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https', :verify_mode => OpenSSL::SSL::VERIFY_NONE) {|http|
        http.request(req)
      }
      @res = JSON.parse(res.body)
    end
  end
end
