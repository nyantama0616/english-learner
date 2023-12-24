require 'rails_helper'

RSpec.describe Word, type: :model do
  before do
    @word = FactoryBot.build(:word)
  end

  it "Factoryによるモデルは作成できる" do
    @word.save!
    expect(@word).to be_valid
  end

  it "nameがnilの場合、モデルの作成に失敗する" do
    @word.name = nil
    expect(@word).to be_invalid
  end

  it "nameが空文字の場合、モデルの作成に失敗する" do
    @word.name = ""
    expect(@word).to be_invalid
  end

  it "nameが256文字の場合、モデルの作成に失敗する" do
    @word.name = "a" * 256
    expect(@word).to be_invalid
  end

  it "nameが重複している場合、モデルの作成に失敗する" do
    @word.save!
    word2 = FactoryBot.build(:word, name: @word.name)
    expect(word2).to be_invalid
  end

  it "nameが?Q?(WordsAPIに存在しない)の場合、モデルの作成に失敗する" do
    @word.name = "?Q?"
    @word.save
    expect(@word).to be_invalid
  end

  it "save時にinfoがfetchされる" do
    @word.save!
    info = Mock::FetchWordInfo.fetch(@word.name)
    expect(@word.pronunciation).to eq(info[:pronunciation])
    expect(@word.stat_frequency).to eq(info[:frequency])
  end

  it "validation時にnameがlemmatizeされる" do
    @word.name = "was"
    @word.valid?
    expect(@word.name).to eq("be")
  end
end
