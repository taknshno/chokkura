require "rails_helper"

RSpec.describe Favorite, type: :model do
  let(:favorite) { create(:favorite) }

  describe "お気に入り登録のテスト" do
    it "user_idとspot_idが適切である場合は登録できる" do
      expect(favorite).to be_valid
    end

    it "user_idが未入力である場合は登録できない" do
      favorite.user_id = nil
      expect(favorite).not_to be_valid
    end

    it "spot_idが未入力である場合は登録できない" do
      favorite.spot_id = nil
      expect(favorite).not_to be_valid
    end

    it "同じuser_idとspot_idのペアが先に登録されている場合は登録ができない" do
      user = FactoryBot.create(:user)
      spot = FactoryBot.create(:spot)
      FactoryBot.create(:favorite, user: user, spot: spot)

      new_favorite = Favorite.new(user: user, spot: spot)
      expect(new_favorite).not_to be_valid
    end
  end
end
