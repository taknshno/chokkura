require 'rails_helper'

RSpec.describe Spot, type: :model do
  describe 'スポット登録のテスト' do
    it '正しい情報が入力されている場合は登録できる' do
      spot = FactoryBot.build(:spot)
      expect(spot).to be_valid
    end

    it 'nameが未入力の場合は登録ができない' do
      spot = FactoryBot.build(:spot, name: nil)
      expect(spot).not_to be_valid
    end

    it 'nameが先に登録しているスポットと重複する場合は登録ができない' do
      existing_spot = FactoryBot.create(:spot, name: 'test')
      new_spot = Spot.new(name: 'test')
      expect(new_spot).not_to be_valid
    end

    it 'areaが未入力の場合は登録ができない' do
      spot = FactoryBot.build(:spot, area: nil)
      expect(spot).not_to be_valid
    end

    it 'addressが未入力の場合は登録ができない' do
      spot = FactoryBot.build(:spot, address: nil)
      expect(spot).not_to be_valid
    end

    it 'addressが160文字を超える場合は登録ができない' do
      spot = FactoryBot.build(:spot, address: SecureRandom.alphanumeric(160) )
      expect(spot).to be_valid
      spot = FactoryBot.build(:spot, address: SecureRandom.alphanumeric(161) )
      expect(spot).not_to be_valid
    end

    it 'phoneが21文字を超える場合は登録ができない' do
      spot = FactoryBot.build(:spot, phone: SecureRandom.alphanumeric(21) )
      expect(spot).to be_valid
      spot = FactoryBot.build(:spot, phone: SecureRandom.alphanumeric(22) )
      expect(spot).not_to be_valid
    end

    it 'holidayが21文字を超える場合は登録ができない' do
      spot = FactoryBot.build(:spot, holiday: SecureRandom.alphanumeric(10) )
      expect(spot).to be_valid
      spot = FactoryBot.build(:spot, holiday: SecureRandom.alphanumeric(11) )
      expect(spot).not_to be_valid
    end

    it 'sales_copyが255文字を超える場合は登録ができない' do
      spot = FactoryBot.build(:spot, sales_copy: SecureRandom.alphanumeric(255) )
      expect(spot).to be_valid
      spot = FactoryBot.build(:spot, sales_copy: SecureRandom.alphanumeric(256) )
      expect(spot).not_to be_valid
    end

    it 'detail_descriptionが未入力の場合は登録ができない' do
      spot = FactoryBot.build(:spot, detail_description: nil )
      expect(spot).not_to be_valid
    end

    it 'simple_descriptionが255文字を超える場合は登録ができない' do
      spot = FactoryBot.build(:spot, simple_description: SecureRandom.alphanumeric(255) )
      expect(spot).to be_valid
      spot = FactoryBot.build(:spot, simple_description: SecureRandom.alphanumeric(256) )
      expect(spot).not_to be_valid
    end
  end
end
