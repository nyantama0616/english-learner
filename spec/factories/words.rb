# spec/factories/words.rb
FactoryBot.define do
  factory :word do
    sequence(:name) { |n| "word#{n}" }
    meaning { "テスト" }
    stat_frequency { 0.0 }
    pronunciation { "test" }
  end
end
