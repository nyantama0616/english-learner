# spec/factories/words.rb
FactoryBot.define do
  factory :word do
    sequence(:name) { |n| "word#{n}" }
    meaning { "テスト" }
    stat_frequency { rand() * 3 }
    pronunciation { "test" }
    reported { false }
  end
end
