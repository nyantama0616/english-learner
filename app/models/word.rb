class Word < ApplicationRecord
  has_one :basic_train_data, dependent: :destroy
  
  validates :name, uniqueness: true
  
  with_options presence: true do
    validates :name
    validates :pronunciation
    validates :stat_frequency
  end
end
