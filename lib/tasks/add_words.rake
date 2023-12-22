namespace :add_words do
  DIR = "#{Rails.root}/lib/data"
  
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

  desc "Add words from word.txt to database"
  task :reading => :environment do
    animal_name = "caracal"
    path = "#{DIR}/word/#{animal_name}.txt"
    puts "===Save words from #{path}==="
    File.open(path, "r") do |file|
      while line = file.gets
        word_name = line.chomp
        unless Word.exists?(name: word_name)
          begin
            word_info = FetchWordInfo.fetch(word_name)
          rescue => exception
            puts "Fetch error. #{exception.message}: #{word_name}"
            next
          end

          next unless word_info
          word_info[:stat_frequency] = word_info.delete(:frequency).to_f
          word = Word.new(word_info)
          
          begin
            word.save!
            puts "saved!: #{word_name}"
          rescue => exception
            puts "Failed. #{exception.message}: #{word_name}"
          end
        else
        end
      end
    end
  end
end
