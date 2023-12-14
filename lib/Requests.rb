module Requests
  WordsApi = {
    fetchEveryData: -> word_name { "https://wordsapiv1.p.rapidapi.com/words/#{word_name}" },
  }
end
