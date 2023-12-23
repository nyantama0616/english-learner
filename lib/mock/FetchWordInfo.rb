module Mock
  module FetchWordInfo
    class << self
      def fetch(word_name)
        if (word_name != "?Q?")
          {
            name: word_name,
            part_of_speech: nil,
            pronunciation: "test",
            frequency: 2.5,
          }
        end
      end
    end
  end
end
