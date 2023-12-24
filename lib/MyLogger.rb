module MyLogger
  module WordsAPI
    @@logger = Logger.new('log/words_api.log')
    
    class << self
      def success(word)
        @@logger.info("Success to fetch: #{word}")
      end
      
      def word_not_found(word)
        @@logger.error("Word not found: #{word}")
      end

      def pronunciation_not_found(word)
        @@logger.error("Pronunciation not found: #{word}")
      end
    end
  end
end
