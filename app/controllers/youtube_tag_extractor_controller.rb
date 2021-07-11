class YoutubeTagExtractorController < ApplicationController
  def index
    if params[:query].present?
      uri = URI('https://freedmtools.com/wp-admin/admin-ajax.php')
      res = Net::HTTP.post_form(uri, 'action' => 'youtube_competitor_keyword', 'search' => params[:query])
      @res = JSON.parse(res.body)
    end
  end
end
