class Flexclip::Video
  require "uri"
  require "net/http"

  def self.search(query, page=1, per_page=30)
    url = URI("https://www.flexclip.com/index.php/?option=com_app&task=app.searchVideo")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(url)
    form_data = [
      ['keywords', query],
      ['page', page],
      ['categories', ''],
      ['numResults', per_page],
      ['sort', 'most_relevant'],
      ['minDuration', '1'],
      ['maxDuration', '1000'],
      ['contentType', 'footage,motionbackgrounds'],
      ['f6d6456f3d5c21118ee043d9fc18af25', '1']
    ]
    request.set_form form_data, 'multipart/form-data'
    response = https.request(request)
    JSON.parse(response.read_body)
  end

  def self.download(video_id)
    url = URI("https://www.flexclip.com/index.php/?option=com_app&task=app.downloadVideo")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(url)
    form_data = [['id', video_id]]
    request.set_form form_data, 'multipart/form-data'
    response = https.request(request)
    JSON.parse(response.read_body)
  end

  def self.meta_data(video_id)
    url = URI("https://www.flexclip.com/index.php/?option=com_app&task=app.getVideo")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(url)
    form_data = [['id', video_id]]
    request.set_form form_data, 'multipart/form-data'
    response = https.request(request)
    JSON.parse(response.read_body)
  end
end