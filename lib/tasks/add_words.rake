namespace :add_words do
  DIR = __dir__
  
  desc "Add words from coca.txt to database"
  task :coca => :environment do
    File.open("#{DIR}/data/coca.txt", "r") do |file, i|
      while line = file.gets
        rank, word_name = line.split(" ")
        break if (rank.to_i > 7995)
        unless Word.exists?(name: word_name)
          word_info = FetchWordInfo.fetch(word_name)
          next unless word_info
          word_info[:stat_frequency] = word_info.delete(:frequency).to_f
          word = Word.new(word_info)
          begin
            word.save!
          rescue => exception
            puts "#{exception.message}: #{word_name}"
          end
        end
      end
    end
  end
end
