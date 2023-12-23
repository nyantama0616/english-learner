require "open-uri"

namespace :temp do
  task :lemmatize => :environment do
    res = WordAnalyzer.lemmatize("legs")
    puts res
  end

  task :part_of_speechs => :environment do
    res = WordAnalyzer.part_of_speechs("He is a docter")
    res = WordAnalyzer.part_of_speechs("He is a docter")
    res = WordAnalyzer.part_of_speechs("Two fingerlike parts on the tip of the trunk allow the elephant to perform delicate maneuvers such as picking a berry from the ground or plucking a single leaf off a tree.")
    p res
  end

  task :lemmatize_sentence => :environment do
    res = WordAnalyzer.lemmatize_sentence("Have you seen a sea gul?")
    p res
  end

  task :reading => :environment do
    animal_name = "caracal"
    dir = "#{Rails.root}/lib/data/reading"
    text = File.read("#{dir}/#{animal_name}.txt")
    res = WordAnalyzer.get_basic_forms(text, sort: true)
    puts res
  end

  task :compare => :environment do
    dir = "#{Rails.root}/lib/data/word"
    words0 = File.read("#{dir}/elephant.txt").split("\n")
    words1 = File.read("#{dir}/elephant2.txt").split("\n")
    words0.length.times do |i|
      if words0[i] != words1[i]
        puts "#{words0[i]} != #{words1[i]}"
      end
    end
  end

  task :fixtures => :environment do
    words = Word.limit(500)
    words.each do |word|
      text = <<~TEXT
        #{word.name}:
          id: #{word.id}
          name: #{word.name}
          pronunciation: aaa
          stat_frequency: #{word.stat_frequency}

      TEXT
      
      puts text
    end

  end
  
  task :get_html => :environment do
    url = "https://ejje.weblio.jp/content/a"
    html = URI.open(url).read
    puts html
  end
end
