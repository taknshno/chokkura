require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザ登録のテスト' do
    it '正しい情報が入力されている場合は登録できる' do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    it 'nameが未入力の場合は登録ができない' do
      user = FactoryBot.build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it 'nameが入力文字列が60文字を超える場合は登録ができない' do
      user = FactoryBot.build(:user, name: SecureRandom.alphanumeric(60) )
      expect(user).to be_valid
      user = FactoryBot.build(:user, name: SecureRandom.alphanumeric(61) )
      expect(user).not_to be_valid
    end

    it 'emailが未入力の場合は登録ができない' do
      user = FactoryBot.build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it 'emailが入力文字列が255文字を超える場合は登録ができない' do
      domain = "@example.com"
      user = FactoryBot.build(:user,
        email: SecureRandom.alphanumeric(255 - domain.length) + domain)
      expect(user).to be_valid
      user = FactoryBot.build(:user,
        email: SecureRandom.alphanumeric(256 - domain.length) + domain)
      expect(user).not_to be_valid
    end

    it 'emailが正しいルールで書かれてない場合は登録ができない' do
      user = FactoryBot.build(:user, email: "test.example.com")
      expect(user).not_to be_valid
      user = FactoryBot.build(:user, email: "test@examplecom")
      expect(user).not_to be_valid
      user = FactoryBot.build(:user, email: "テスト@example.com")
      expect(user).not_to be_valid
    end

    it 'emailが先に登録しているアカウントと重複する場合は登録ができない' do
      existing_user = FactoryBot.create(:user, email: 'test@example.com')
      new_user = User.new(email: 'test@example.com')
      expect(new_user).not_to be_valid
    end

    it 'passwordが6文字以上128文字以内でない場合は登録できない' do
      # 6 Characters
      password = SecureRandom.alphanumeric(6)
      user = FactoryBot.build(:user, password: password, password_confirmation: password )
      expect(user).to be_valid
      # 5 Characters
      password = SecureRandom.alphanumeric(5)
      user = FactoryBot.build(:user, password: password, password_confirmation: password )
      expect(user).not_to be_valid
      # 128 Characters
      password = SecureRandom.alphanumeric(128)
      user = FactoryBot.build(:user, password: password, password_confirmation: password )
      expect(user).to be_valid
      # 129 Characters
      password = SecureRandom.alphanumeric(129)
      user = FactoryBot.build(:user, password: password, password_confirmation: password )
      expect(user).not_to be_valid
    end
  end
end
