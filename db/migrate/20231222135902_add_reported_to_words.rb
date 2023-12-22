class AddReportedToWords < ActiveRecord::Migration[7.0]
  def change
    add_column :words, :reported, :boolean, default: false
  end
end
