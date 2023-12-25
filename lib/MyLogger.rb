module MyLogger
  module WordsAPI
    @@logger = Logger.new('log/words_api.log')
    
    class << self
      def success(word)
        @@logger.info("Success to fetch: #{word}")
      end
      
      def error(word, message, code)
        @@logger.error("Failed to fetch: #{word} (#{message}), code: #{code}")
      end
    end
  end
end
