class Biteable::Photos
  def self.search(page, query, per_page)
    page = 1 unless page.present?
    query = 'nature' unless query.present?
    page = 30 unless per_page.present?
    uri = URI("https://api.unsplash.com/search/photos?query=#{query}&page=#{page}&per_page=#{per_page}")
    req = Net::HTTP::Get.new(uri)
    req['authorization'] = ENV['BITEABLE_AUTH']
    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https', :verify_mode => OpenSSL::SSL::VERIFY_NONE) {|http|
      http.request(req)
    }
    JSON.parse(res.body)
  end
end