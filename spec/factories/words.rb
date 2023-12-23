# spec/factories/words.rb
FactoryBot.define do
  factory :word do
    sequence(:name) { |n| "word#{n}" }
    meaning { "テスト" }
    reported { false }
  end
end
