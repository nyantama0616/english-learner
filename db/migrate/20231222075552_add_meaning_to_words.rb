class AddMeaningToWords < ActiveRecord::Migration[7.0]
  def change
    add_column :words, :meaning, :string, default: ""
  end
end
