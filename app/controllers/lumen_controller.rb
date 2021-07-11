class LumenController < ApplicationController
  require "uri"
  require "net/http"

  def index
    page = params[:page].present? ? params[:page] : 1
    url = URI("https://lumen5.com/api/media-search/")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["cookie"] = "_ga=GA1.2.1886474573.1623467107; _gcl_au=1.1.1210401058.1623467115; _fbp=fb.1.1623467118566.162022086; intercom-id-v8khjgvl=73d83247-edce-43f3-9d51-86588ea066fb; _hjid=06fbfe53-3937-421a-8028-fd16394ae76b; hubspotutk=741d46ca380fcd01885a19039f40c59b; __stripe_mid=f368e486-b339-48ed-8f07-4f5842634812564aa0; media-filter-reset=1; media-filter={}; _gid=GA1.2.391492586.1625244673; _pin_unauth=dWlkPVl6ZGpaVGcyTnpJdFlUZzFNQzAwT0Rka0xXSm1Oak10T0dJNU9HUXpaVGxoTW1VeQ; intercom-session-v8khjgvl=; _hjIncludedInPageviewSample=1; _hjAbsoluteSessionInProgress=0; _hjIncludedInSessionSample=1; csrftoken=JoJn0B08jvpmElUABZaqxlKJzTUgYHg4ZziYtM2BtPVvA3ZxF8HfFSGl2RThyHZu; sessionid=qr826uej8w2ay7wk2dtwgicav7xf45qs; mp_f3ae0c29948ed28763f34fab92285425_mixpanel=%7B%22distinct_id%22%3A%20885027%2C%22%24device_id%22%3A%20%22179fe33a900257-07d225a9ea7c03-3e740b5c-100200-179fe33a901b5%22%2C%22%24initial_referrer%22%3A%20%22https%3A%2F%2Flumen5.com%2Fauth%2Fsignup%2F%22%2C%22%24initial_referring_domain%22%3A%20%22lumen5.com%22%2C%22%24user_id%22%3A%20885027%2C%22utm_source%20%5Blast%20touch%5D%22%3A%20%22%22%2C%22utm_medium%20%5Blast%20touch%5D%22%3A%20%22%22%2C%22utm_campaign%20%5Blast%20touch%5D%22%3A%20%22%22%2C%22utm_content%20%5Blast%20touch%5D%22%3A%20%22%22%2C%22utm_term%20%5Blast%20touch%5D%22%3A%20%22%22%7D; _uetsid=07f452d0db5611ebbae93b599537f80b; _uetvid=032bacc0cb2b11eb8fd071865d1f980d; __hstc=188107319.741d46ca380fcd01885a19039f40c59b.1623467482206.1623467482206.1625258791177.2; __hssrc=1; __hssc=188107319.1.1625258791177; _gat=1"
    request["x-csrftoken"] = "WXPA2NYVrDWx72Fia9WadcEJlXOtI8pfc8obvY0oBXsG3KKfeitZlJAlOVNui88F"
    form_data = [['q', "#{params[:query]}"],['source', 'recommended'],['page', "#{page}"],['filter', 'videos'],['video_duration', '6'],['autocorrect', 'true'],['did_you_mean', 'true'],['sort', '']]
    request.set_form form_data, 'multipart/form-data'
    response = https.request(request)
    @res = JSON.parse(response.read_body)

    p @res

    respond_to do |format|
      format.html
      format.js
    end
  end
end
