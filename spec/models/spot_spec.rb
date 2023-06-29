require "rails_helper"

RSpec.describe Spot, type: :model do
  describe "スポット登録のテスト" do
    it "正しい情報が入力されている場合は登録できる" do
      spot = build(:spot)
      expect(spot).to be_valid
    end

    it "nameが未入力の場合は登録ができない" do
      spot = build(:spot, name: nil)
      expect(spot).not_to be_valid
    end

    it "nameが先に登録しているスポットと重複する場合は登録ができない" do
      existing_spot = create(:spot, name: "test")
      new_spot = Spot.new(name: "test")
      expect(new_spot).not_to be_valid
    end

    it "areaが未入力の場合は登録ができない" do
      spot = build(:spot, area: nil)
      expect(spot).not_to be_valid
    end

    it "addressが未入力の場合は登録ができない" do
      spot = build(:spot, address: nil)
      expect(spot).not_to be_valid
    end

    it "addressが160文字を超える場合は登録ができない" do
      spot = build(:spot, address: SecureRandom.alphanumeric(160))
      expect(spot).to be_valid
      spot = build(:spot, address: SecureRandom.alphanumeric(161))
      expect(spot).not_to be_valid
    end

    it "phoneが21文字を超える場合は登録ができない" do
      spot = build(:spot, phone: SecureRandom.alphanumeric(21))
      expect(spot).to be_valid
      spot = build(:spot, phone: SecureRandom.alphanumeric(22))
      expect(spot).not_to be_valid
    end

    it "holidayが21文字を超える場合は登録ができない" do
      spot = build(:spot, holiday: SecureRandom.alphanumeric(10))
      expect(spot).to be_valid
      spot = build(:spot, holiday: SecureRandom.alphanumeric(11))
      expect(spot).not_to be_valid
    end

    it "sales_copyが255文字を超える場合は登録ができない" do
      spot = build(:spot, sales_copy: SecureRandom.alphanumeric(255))
      expect(spot).to be_valid
      spot = build(:spot, sales_copy: SecureRandom.alphanumeric(256))
      expect(spot).not_to be_valid
    end

    it "detail_descriptionが未入力の場合は登録ができない" do
      spot = build(:spot, detail_description: nil)
      expect(spot).not_to be_valid
    end

    it "simple_descriptionが255文字を超える場合は登録ができない" do
      spot =
        build(
          :spot,
          simple_description: SecureRandom.alphanumeric(255),
        )
      expect(spot).to be_valid
      spot =
        build(
          :spot,
          simple_description: SecureRandom.alphanumeric(256),
        )
      expect(spot).not_to be_valid
    end
  end
  describe "検索機能" do
    it "クエリのareaが一致したスポットが返される" do
      spot = create(:spot, area: "県央")
      expect(Spot.area_search("県央")).to include(spot)
    end

    it "クエリのareaが一致しない場合はスポットが返されない" do
      spot = create(:spot, area: "鹿行")
      expect(Spot.area_search("県央")).to be_empty
    end

    it "クエリのtagが一致したスポットが返される" do
      spot = create(:spot)
      tag = create(:tag, id: 10)
      create(:tagging, spot: spot, tag: tag)
      expect(Spot.tag_search(10)).to include(spot)
    end

    it "クエリのtagが一致しない場合はスポットが返されない" do
      spot = create(:spot)
      tag = create(:tag, id: 50)
      create(:tagging, spot: spot, tag: tag)
      expect(Spot.tag_search(10)).to be_empty
    end

    it "クエリのareaとtagが完全一致した場合はそのスポットが返される" do
      spot = create(:spot, area: "県央")
      tag = create(:tag, id: 10)
      create(:tagging, spot: spot, tag: tag)
      expect(Spot.area_search("県央").tag_search(10)).to include(spot)
    end

    it "クエリのareaと一致し、tagが一致しない場合はスポットが返されない" do
      spot = create(:spot, area: "県央")
      tag = create(:tag, id: 10)
      create(:tagging, spot: spot, tag: tag)
      expect(Spot.area_search("県央").tag_search(50)).to be_empty
    end

    it "クエリのtagと一致し、areaが一致しない場合はスポットが返されない" do
      spot = create(:spot, area: "県央")
      tag = create(:tag, id: 10)
      create(:tagging, spot: spot, tag: tag)
      expect(Spot.area_search("鹿行").tag_search(10)).to be_empty
    end
  end
end
