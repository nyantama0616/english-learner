class Word < ApplicationRecord
  FetchInfo = Rails.env.development? ? FetchWordInfo : Mock::FetchWordInfo

  has_one :basic_train_data, dependent: :destroy
  
  validates :name, uniqueness: true, presence: true, length: { maximum: 255 }

  before_save :set_info

  def info
    json = as_json(only: [:id, :name, :meaning, :stat_frequency, :reported])
    json["word"] = json.delete("name")
    json.deep_transform_keys! { |key| key.camelize(:lower) }
    json
  end

  private

  def set_info
    info = FetchInfo.fetch(self.name)
    
    if info.nil?
      raise NameError, "Failed to fetch info: #{self.name}"
    end

    self.pronunciation = info[:pronunciation]
    self.stat_frequency = info[:frequency]
  end
end
