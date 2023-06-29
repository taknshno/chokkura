require "rails_helper"

RSpec.describe "ユーザ管理機能", type: :system do
  describe "ユーザ登録のテスト" do
    it "アカウントの登録が完了したら、ログイン中のままトップページに遷移する" do
      visit new_user_registration_path
      fill_in '氏名', with: 'John Doe'
      fill_in 'メールアドレス', with: 'john@example.com'
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード（確認用）', with: 'password'
      click_button 'アカウント登録'
      expect(current_path).to eq spots_path
      expect(page).to have_text('John Doe')
    end
  end

  describe "セッション機能のテスト" do
    let!(:user) { create(:user, name: 'John Doe', email: 'john@example.com', password: 'password', password_confirmation: 'password') }
    it "ログインに成功したらトップページに遷移する" do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'john@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
      expect(current_path).to eq spots_path
      expect(page).to have_text('ログインしました')
    end

    it "ログインした一般ユーザは自分の詳細画面(マイページ)にアクセスできる" do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'john@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
      find(".close").click
      click_link "John Doe"
      expect(current_path).to eq user_path(id: user.id)
      expect(page).to have_text('John Doeさんのページ')
    end
    it "アクセス制限により他人の詳細画面にアクセスするとスポット一覧に遷移する" do
      another_user = create(:user, name: 'another', email: 'another@example.com', password: 'password', password_confirmation: 'password')
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'john@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
      visit user_path(id: another_user.id)
      expect(current_path).to eq spots_path
    end
    it "ログアウトができる" do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'john@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
      find(".close").click
      find(".navbar-toggler-icon").click
      click_link "ログアウト"
      expect(page).to have_text('ログアウトしました')
    end
  end
  describe "管理画面のテスト" do
    let!(:user) { create(:user, name: "common_user", email: "common@example.com",
      password: "common_pass",password_confirmation: "common_pass") }
    let!(:admin_user) { create(:admin_user, name: "admin_user", email: "admin@example.com",
      password: "admin_pass", password_confirmation: "admin_pass" ) }

    it "管理者ユーザは管理画面にアクセスできること" do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'admin@example.com'
      fill_in 'パスワード', with: 'admin_pass'
      click_button 'ログイン'
      visit admin_index_path
      expect(page).to have_text('管理者メニュー')
    end
    it "アクセス制限により一般ユーザが管理画面にアクセスするとスポット一覧に遷移する" do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'common@example.com'
      fill_in 'パスワード', with: 'common_pass'
      click_button 'ログイン'
      visit admin_index_path
      expect(page).to have_text('アクセスが拒否されました')
      expect(current_path).to eq spots_path
    end
  #   it "管理ユーザはユーザの詳細画面にアクセスできること" do
  #     visit new_user_session_path
  #     fill_in "Email", with: "admin@example.com"
  #     fill_in "Password", with: "admin_pass"
  #     click_button "ログインする"
  #     visit admin_users_path
  #     find("#show_10").click
  #     expect(page).to have_content "sample@example.com"
  #   end
  #   it "管理ユーザはユーザの編集画面からユーザを編集できること" do
  #     visit new_user_session_path
  #     fill_in "Email", with: "admin@example.com"
  #     fill_in "Password", with: "admin_pass"
  #     click_button "ログインする"
  #     visit admin_users_path
  #     find("#edit_10").click
  #     fill_in "名前", with: "edit_name"
  #     fill_in "メールアドレス", with: "edit@example.com"
  #     fill_in "パスワード", with: "12345678"
  #     fill_in "パスワード(再確認)", with: "12345678"
  #     click_button "編集する"
  #     find("#show_10").click
  #     expect(page).to have_content "edit_name"
  #   end
  #   it "管理ユーザはユーザの削除をできること" do
  #     visit new_user_session_path
  #     fill_in "Email", with: "admin@example.com"
  #     fill_in "Password", with: "admin_pass"
  #     click_button "ログインする"
  #     visit admin_users_path
  #     expect(page).to have_content "sample@example.com"
  #     find("#delete_10").click
  #     page.driver.browser.switch_to.alert.accept
  #     expect(page).not_to have_content "sample@example.com"
  #   end
  end
end
