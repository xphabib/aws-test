class TemporaryPhoneNumberController < ApplicationController
  def index
    @doc = Nokogiri::HTML(URI.open('https://receive-sms-online.info/'))
    @arr = []
    @doc.css('div.Table div.Row div.Cell', 'div a').each do |phone|
      hsh = {}
      hsh[:country] = phone.css('div')&.children&.first&.text
      ref = phone.css('div a')&.first&.attributes.present? ? phone.css('div a')&.first&.attributes['href'].text : 0
      hsh[:referer] = "https://receive-sms-online.info/#{ref}"
      phone = phone.css('div a')&.first&.text&.remove('+')&.gsub(/\u00a0/, '')
      hsh[:number] = phone
      @arr << hsh if phone.present?
    end
  end

  def inbox
    phone_no = params[:phone]
    referer = params[:refer]
    uri = URI("https://receive-sms-online.info/get_sms_439704.php?phone=#{phone_no}")
    req = Net::HTTP::Get.new(uri)
    req['referer'] = referer
    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https', :verify_mode => OpenSSL::SSL::VERIFY_NONE) {|http|
      http.request(req)
    }
    @res = JSON.parse(res.body)
    respond_to do |format|
      format.html
      format.json { render json: {res: @res} }
    end
  end
end
