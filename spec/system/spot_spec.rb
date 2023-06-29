require "rails_helper"

RSpec.describe "スポット管理機能", type: :system do
  describe "スポット管理画面へのアクセス制限" do
    include_context "login_setup"
    it "一般ユーザはスポット作成画面への遷移に失敗する" do
      visit new_admin_spot_path
      expect(current_path).to eq spots_path
      expect(page).to have_text('アクセスが拒否されました')
    end
  end

  describe "スポット管理画面の表示" do
    include_context "admin_login_setup"
    it "管理ユーザはスポット作成画面へ遷移できる" do
      visit new_admin_spot_path
      expect(current_path).to eq new_admin_spot_path
    end
  end

  describe "スポット新規登録" do
    include_context "admin_login_setup"
    it "管理者ユーザはスポット作成画面に移動してスポットを新規登録できる" do
      visit new_admin_spot_path
      fill_in "スポット名", with: "test_spot"
      select "県央", from: "所在エリア"
      fill_in "住所", with: "test_address"
      fill_in "電話番号", with: "000-0000-0000"
      fill_in "定休日", with: "日曜日"
      fill_in "セールスコピー", with: "test_copy"
      fill_in "簡易説明", with: "test_simple_text"
      fill_in "詳細説明", with: "test_detail_text"
      click_button "確認する"
      click_button "登録する"
      expect(page).to have_text "観光スポットを登録しました"
      expect(page).to have_text "test_spot"
    end
  end

  describe "スポット一覧表示" do
    include_context "admin_login_setup"
    it "作成したスポットは一覧で表示できる" do
      spot1 = create(:spot, name: 'abc')
      spot2 = create(:spot, name: 'xyz')
      visit spots_path
      expect(page).to have_text "abc"
      expect(page).to have_text "xyz"
    end
  end
  describe "スポット編集機能" do
    include_context "admin_login_setup"
    it "スポット管理画面に移動してスポットを編集できる" do
      spot = create(:spot, name: 'abc')
      visit admin_spots_path
      find("#edit_#{spot.id}").click
      fill_in "スポット名", with: "xyz"
      click_button "確認する"
      expect(page).to have_text('観光スポットを更新しました')
      expect(page).not_to have_text "abc"
      expect(page).to have_text "xyz"
    end
  end

  describe "スポット削除機能" do
    include_context "admin_login_setup"
    it "管理画面に移動してスポットを削除できる" do
      spot = create(:spot, name: 'abc')
      visit admin_spots_path
      expect(page).to have_text "abc"
      find("#delete_#{spot.id}").click
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_text('観光スポットを削除しました')
      expect(page).not_to have_content "abc"
    end
  end
end