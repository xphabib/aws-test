class FakeAddressGeneratorController < ApplicationController
  def index
    lang = params[:lang].present? ? params[:lang] : 'en_US'
    uri = URI('https://www.prepostseo.com/frontend/fakeAddressGenerator')
    res = Net::HTTP.post_form(uri,  'lang' => lang)
    @res = JSON.parse(res.body)
  end
end
