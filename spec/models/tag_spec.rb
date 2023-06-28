require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'タグ登録のテスト' do
    it '正しい情報が入力されている場合は登録できる' do
      tag = FactoryBot.build(:tag)
      expect(tag).to be_valid
    end

    it 'nameが未入力の場合は登録ができない' do
      tag = FactoryBot.build(:tag, name: nil)
      expect(tag).not_to be_valid
    end

    it 'nameが先に登録しているタグと重複する場合は登録ができない' do
      existing_tag = FactoryBot.create(:tag, name: 'test')
      new_tag = Tag.new(name: 'test')
      expect(new_tag).not_to be_valid
    end

    it 'nameが100文字を超える場合は登録ができない' do
      tag = FactoryBot.build(:tag, name: SecureRandom.alphanumeric(100) )
      expect(tag).to be_valid
      tag = FactoryBot.build(:tag, name: SecureRandom.alphanumeric(101) )
      expect(tag).not_to be_valid
    end
  end
end
