class Word < ApplicationRecord
  has_one :basic_train_data, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
