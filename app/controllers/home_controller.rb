class HomeController < ApplicationController
  require 'net/http'
  require 'open-uri'

  def index
    @page = params[:page].present? ? params[:page] : 1
    limit = 30
    uri = URI("https://api.supa.ru/library/video?service=storyblocks&page=#{@page}&limit=#{limit}&search=#{params[:query]}&content_type=footage") if params[:query].present?
    uri = URI("https://api.supa.ru/library/video?service=storyblocks&page=#{@page}&limit=#{limit}&content_type=footage") unless params[:query].present?
    res = Net::HTTP.get_response(uri)
    @res = JSON.parse(res.body)
    respond_to do |format|
        format.html
        format.json { render json: {res: @res} }
    end
  end

  def image
    @res = Biteable::Photos.search(params[:page], params[:query], 30)
    render layout: "image"
  end

  def download
    uri = URI("https://api.supa.ru/library/resource?id=#{params[:id]}&service=#{params[:service]}")
    res = Net::HTTP.get_response(uri)
    @res = JSON.parse(res.body)

    unless @res.present?
      respond_to do |format|
        format.html { redirect_to request.url, notice: 'page was successfully reload.' }
        format.json { head :no_content }
      end
    end

    uri2 = URI('https://api.supa.ru/cropper-helper/preview')
    res2 = Net::HTTP.post_form(uri2, 'video_url' => @res['url'], 'frames' => 10, 'frames_width' => 168, 'cache' => true)
    @res2 = JSON.parse(res2.body)
    render layout: "download"
  end

  def confirm
    @res = url_call(params[:task_id])
    @result = @res['source_original']['url']
    render layout: "download"
  end

  def links

  end

  def test
    @source = open("https://youtube.com").read
  end

  private 
  def url_call(task_id)
    uri = URI("https://api.supa.ru/cropper-helper/task/#{params[:task_id]}")
    res = Net::HTTP.get_response(uri)
    result = JSON.parse(res.body)
    if result['state'] == "done"
      return result
    else
      url_call(task_id)
    end
  end
end
