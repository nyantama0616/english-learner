class CreateBasicTrainData < ActiveRecord::Migration[7.0]
  def change
    create_table :basic_train_data do |t|
      t.integer :answer_count
      t.integer :right_count #TODO: 後から消すかも
      t.integer :reaction_time
      t.belongs_to :word, index: { unique: true }, foreign_key: true
      t.timestamps
    end
  end
end
