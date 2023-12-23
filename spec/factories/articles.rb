FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "Test Article #{n}" }
    body { 
      <<-TEXT
        word0 word1.
        
        ### Why is pandas so popular?
        aa bb  cc   dd\n ee
      TEXT
    }
  end
end
