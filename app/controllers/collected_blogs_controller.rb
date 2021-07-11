class CollectedBlogsController < ApplicationController
  def index
    if params[:query].present?
      @collected_blogs = CollectedBlog.where('title LIKE ?', "%#{params[:query]}%" )
    else
      @collected_blogs = CollectedBlog.all
    end
  end

  def youtube_channel
    if params[:query].present?
      @youtube_channels = YoutubeChannel.where('title LIKE ?', "%#{params[:query]}%" )
    else
      @youtube_channels = YoutubeChannel.all
    end
  end

  def useful_links
    if params[:query].present?
      @useful_links = UsefulLink.where('title LIKE ?', "%#{params[:query]}%" )
    else
      @useful_links = UsefulLink.all
    end
  end
end
