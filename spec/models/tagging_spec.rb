require 'rails_helper'

RSpec.describe Tagging, type: :model do
  let(:tagging) { create(:tagging) }

  describe "お気に入り登録のテスト" do
    it "spot_idとspot_idが適切である場合は登録できる" do
      expect(tagging).to be_valid
    end

    it "spot_idが未入力である場合は登録できない" do
      tagging.spot_id = nil
      expect(tagging).not_to be_valid
    end

    it "tag_idが未入力である場合は登録できない" do
      tagging.tag_id = nil
      expect(tagging).not_to be_valid
    end

    it "同じspot_idとtag_idのペアが先に登録されている場合は登録ができない" do
      spot = FactoryBot.create(:spot)
      tag = FactoryBot.create(:tag)
      FactoryBot.create(:tagging, spot: spot, tag: tag)

      new_tagging = Tagging.new(spot: spot, tag: tag)
      expect(new_tagging).not_to be_valid
    end
  end
end
