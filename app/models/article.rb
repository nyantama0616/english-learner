class Article < ApplicationRecord
  validates :title, length: { maximum: 255 }, presence: true
  validates :body, length: { maximum: 10000 }, presence: true

  before_save :set_word_count

  def calc_word_count
    body.split.reject {|word| word.include?("#")}.count
  end

  def words
    WordAnalyzer.get_words(body)
  end

  private

  def set_word_count
    self.word_count = calc_word_count
  end
end
