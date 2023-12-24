class Word < ApplicationRecord
  FetchInfo = Rails.env.development? ? FetchWordInfo : Mock::FetchWordInfo

  has_one :basic_train_data, dependent: :destroy
  
  validates :name, uniqueness: true, presence: true, length: { maximum: 255 }

  before_validation :lemmatize, :set_info

  def info
    json = as_json(only: [:id, :name, :meaning, :stat_frequency, :reported])
    json["word"] = json.delete("name")
    json.deep_transform_keys! { |key| key.camelize(:lower) }
    json
  end

  private

  def set_info
    return false if Word.exists?(name: self.name) #無駄にinfoをfetchしないようにする

    info = FetchInfo.fetch(self.name)
    
    if info.nil?
      errors.add(:base, "Failed to fetch info: #{self.name}")
      return false
    end

    self.pronunciation = info[:pronunciation]
    self.stat_frequency = info[:frequency]
  end

  def lemmatize
    self.name = WordAnalyzer.lemmatize(self.name) if self.name
  end
end
