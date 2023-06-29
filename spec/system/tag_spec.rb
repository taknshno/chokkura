require "rails_helper"

RSpec.describe "タグ管理機能", type: :system do
  describe "タグ管理画面へのアクセス制限" do
    include_context "login_setup"
    it "一般ユーザーはタグ作成画面への遷移に失敗する" do
      visit new_admin_tag_path
      expect(current_path).to eq spots_path
      expect(page).to have_text('アクセスが拒否されました')
    end
  end

  describe "タグ管理画面の表示" do
    include_context "admin_login_setup"
    it "管理ユーザーはタグ作成画面へ遷移できる" do
      visit new_admin_tag_path
      expect(current_path).to eq new_admin_tag_path
    end
  end

  describe "タグ新規作成" do
    include_context "admin_login_setup"
    it "タグ作成画面に移動してタグを作成できる" do
      visit new_admin_tag_path
      fill_in "タグ名", with: "test_tag"
      click_button "確認する"
      click_button "登録する"
      expect(page).to have_text "タグを新規作成しました"
      expect(page).to have_text "test_tag"
    end
  end

  describe "タグ一覧表示" do
    include_context "admin_login_setup"
    it "タグ管理画面に移動して一覧表示できる" do
      tag1 = create(:tag, name: 'abc')
      tag2 = create(:tag, name: 'xyz')
      visit admin_tags_path
      expect(page).to have_text "abc"
      expect(page).to have_text "xyz"
    end
  end

  describe "タグ編集機能" do
    include_context "admin_login_setup"
    it "タグ管理画面に移動してタグを編集できる" do
      tag = create(:tag, name: 'abc')
      visit admin_tags_path
      find("#edit_#{tag.id}").click
      fill_in "タグ名", with: "xyz"
      click_button "確認する"
      expect(page).to have_text('タグを編集しました')
      expect(page).not_to have_text "abc"
      expect(page).to have_text "xyz"
    end
  end

  describe "タグ削除機能" do
    include_context "admin_login_setup"
    it "管理画面に移動してタグを削除できる" do
      tag = create(:tag, name: 'abc')
      visit admin_tags_path
      expect(page).to have_text "abc"
      find("#delete_#{tag.id}").click
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_text('タグを削除しました')
      expect(page).not_to have_content "abc"
    end
  end
end