class FlexclipController < ApplicationController
  def index
    page = params[:page].present? ? params[:page] : 1
    query = params[:query].present? ? params[:query] : 'spring'
    data = Flexclip::Video.search(query, page, 30)
    @res = data['json']['results']
  end

  def download
    @data = Flexclip::Video.download(params[:video_id])
  end
end
