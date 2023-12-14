require "net/http"

#TODO: Wordモデルの仕事かもね
module FetchWordInfo
  class << self
    def fetch(word_name)
      check_word_exists(word_name) #もし単語が既にDBに存在していたらエラーを出す(不要なAPIリクエストを防ぐため)

      uri = URI(Requests::WordsApi[:fetchEveryData].call(word_name))
      header = {
        "X-RapidAPI-Key" => API_KEY,
        "X-RapidAPI-Host" => HOST,
      }
      request = Net::HTTP::Get.new(uri, header)

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      json = JSON.parse(response.body)
      if json["success"] == false
        puts "#{json["message"]}: #{word_name}"
        return
      end
      
      res = {
        name: json["word"],
        # part_of_speech: json["results"].map{ |r| r["partOfSpeech"] },
        part_of_speech: nil, #TODO: modelがsetをサポートしていないので、一旦nullにしておく
        pronunciation: json["pronunciation"],
        frequency: json["frequency"],
      }
    end

    private

    def check_word_exists(word_name)
      if Word.exists?(name: word_name)
        raise "Word already exists: #{word_name}"
      end
    end
  end

  private

  API_KEY = ENV["X_RapidAPI_Key"]
  HOST = "wordsapiv1.p.rapidapi.com"
end
