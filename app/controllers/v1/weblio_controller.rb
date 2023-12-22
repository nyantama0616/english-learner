require "open-uri"

class V1::WeblioController < ApplicationController
  def show
    word = weblio_params[:word]
    url = "https://ejje.weblio.jp/content/#{word}"
    html = URI.open(url).read
    render html: html.html_safe
  end

  def weblio_params
    params.permit(:word)
  end
end
