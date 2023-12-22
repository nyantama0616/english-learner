class AddIndexToWordsStatFrequency < ActiveRecord::Migration[7.0]
  def change
    add_index :words, :stat_frequency
  end
end
