require "rails_helper"

RSpec.describe "タグ付け機能", type: :system do
  describe "スポット新規登録時のタグ付け" do
    include_context "admin_login_setup"
    it "スポット登録画面でタグにチェックを入れるとタグ付けができる" do
      tag1 = create(:tag, name: 'abc')
      tag2 = create(:tag, name: 'lmn')
      tag3 = create(:tag, name: 'xyz')
      visit new_admin_spot_path
      fill_in "スポット名", with: "test_spot"
      select "県央", from: "所在エリア"
      fill_in "住所", with: "test_address"
      fill_in "電話番号", with: "000-0000-0000"
      fill_in "定休日", with: "日曜日"
      fill_in "セールスコピー", with: "test_copy"
      fill_in "簡易説明", with: "test_simple_text"
      fill_in "詳細説明", with: "test_detail_text"
      find("#spot_tag_ids_#{tag1.id}").click
      find("#spot_tag_ids_#{tag3.id}").click
      click_button "確認する"
      click_button "登録する"
      expect(page).to have_text "観光スポットを登録しました"
      click_link "詳細"
      expect(page).to have_css("#tagged_#{tag1.id}")
      expect(page).not_to have_css("#tagged_#{tag2.id}")
      expect(page).to have_css("#tagged_#{tag3.id}")
    end
  end

  describe "既存のスポット編集時のタグ付け" do
    include_context "admin_login_setup"
    it "スポット編集画面でタグにチェックを入れるとタグ付けができる" do
      spot = create(:spot)
      tag1 = create(:tag, name: 'abc')
      tag2 = create(:tag, name: 'lmn')
      tag3 = create(:tag, name: 'xyz')
      visit edit_admin_spot_path(id: spot.id)
      find("#spot_tag_ids_#{tag1.id}").click
      find("#spot_tag_ids_#{tag3.id}").click
      click_button "確認する"
      expect(page).to have_text "観光スポットを更新しました"
      click_link "詳細"
      expect(page).to have_css("#tagged_#{tag1.id}")
      expect(page).not_to have_css("#tagged_#{tag2.id}")
      expect(page).to have_css("#tagged_#{tag3.id}")
    end
  end

  describe "スポットに付けられているタグの解除" do
    include_context "admin_login_setup"
    it "スポット編集画面でタグ付けされたタグのチェックを外すとタグ付けが解除ができる" do
      spot = create(:spot)
      tag1 = create(:tag, name: 'abc')
      tag2 = create(:tag, name: 'lmn')
      tag3 = create(:tag, name: 'xyz')
      create(:tagging, spot: spot, tag: tag1)
      create(:tagging, spot: spot, tag: tag2)
      create(:tagging, spot: spot, tag: tag3)
      visit edit_admin_spot_path(id: spot.id)
      find("#spot_tag_ids_#{tag3.id}").click
      click_button "確認する"
      expect(page).to have_text "観光スポットを更新しました"
      click_link "詳細"
      expect(page).to have_css("#tagged_#{tag1.id}")
      expect(page).to have_css("#tagged_#{tag2.id}")
      expect(page).not_to have_css("#tagged_#{tag3.id}")
    end
  end
end