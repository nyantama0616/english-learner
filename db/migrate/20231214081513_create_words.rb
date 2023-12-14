class CreateWords < ActiveRecord::Migration[7.0]
  def change
    create_table :words do |t|
      t.string :name, null: false
      t.string :part_of_speech, set: %w(noun verb adjective adverb auxiliary verb pronoun preposition conjunction interjection, article) #TODO: 意味ないよな！？
      t.integer :real_frequency, null: false, default: 0
      t.float  :stat_frequency, null: false, default: 0
      t.timestamps
    end
    
    add_index :words, :name, unique: true #同一の英単語が登録されないようにする
  end
end
