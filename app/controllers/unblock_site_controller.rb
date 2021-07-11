class UnblockSiteController < ApplicationController
  def index
    if params[:query].present?
      @doc = Nokogiri::HTML(URI.open(params[:query]))
    end
  rescue => e
    @doc = Nokogiri::HTML(URI.open("https://www.google.com/search?q=#{params[:query]}"))
  end
end
