class ClipchampController < ApplicationController
  def videos
    page = params[:page].present? ? params[:page].to_i - 1 : nil
    data = Clipchamp::Content.videos(params[:query], page)
    @res = data
  end

  def video_show
    @res = Clipchamp::Content.related_video(params[:id])
    @download = Clipchamp::Content.download(params[:vid])
    @data = Flexclip::Video.download(params[:vid])
  end

  def photos

  end

  def audios

  end
end
