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

  describe "アクセス制限のテスト" do
    let!(:user) { create(:user, name: 'John Doe', email: 'john@example.com', password: 'password', password_confirmation: 'password') }

    it "自分の詳細画面(マイページ)にアクセスできる" do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'john@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
      find(".close").click
      click_link "John Doe"
      expect(current_path).to eq user_path(id: user.id)
      expect(page).to have_text('John Doeさんのページ')
    end
    it "他のユーザーの詳細画面にアクセスするとスポット一覧に遷移する" do
      another_user = create(:user, name: 'another', email: 'another@example.com', password: 'password', password_confirmation: 'password')
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'john@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
      visit user_path(id: another_user.id)
      expect(current_path).to eq spots_path
    end
  end

  describe "管理画面に関するテスト" do
    let!(:user) { create(:user, name: "common_user", email: "common@example.com",
      password: "common_pass",password_confirmation: "common_pass") }
    let!(:admin_user) { create(:admin_user, name: "admin_user", email: "admin@example.com",
      password: "admin_pass", password_confirmation: "admin_pass" ) }
    let!(:new_user) { create(:new_user, name: "new_common_user", email: "common2@example.com",
      password: "new_common_pass",password_confirmation: "new_common_pass") }
    let!(:new_admin_user) { create(:admin_user, name: "new_admin_user", email: "admin2@example.com",
      password: "new_admin_pass", password_confirmation: "new_admin_pass" ) }

    it "管理者ユーザは管理画面にアクセスできること" do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'admin@example.com'
      fill_in 'パスワード', with: 'admin_pass'
      click_button 'ログイン'
      visit admin_index_path
      expect(page).to have_text('管理者メニュー')
    end
    it "一般ユーザが管理画面にアクセスするとスポット一覧に遷移する" do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'common@example.com'
      fill_in 'パスワード', with: 'common_pass'
      click_button 'ログイン'
      visit admin_index_path
      expect(page).to have_text('アクセスが拒否されました')
      expect(current_path).to eq spots_path
    end
    it "管理者ユーザは他のユーザの詳細画面にアクセスできる" do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'admin@example.com'
      fill_in 'パスワード', with: 'admin_pass'
      click_button 'ログイン'
      visit admin_users_path
      find("#show_#{user.id}").click
      expect(page).to have_text("#{user.name}さんのページ")
    end
    it "一般ユーザが他のユーザの詳細画面にアクセスするとスポット一覧に遷移する" do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'common@example.com'
      fill_in 'パスワード', with: 'common_pass'
      click_button 'ログイン'
      visit user_path(new_user.id)
      expect(current_path).to eq spots_path
      expect(page).to have_text("アクセスが拒否されました")
    end
    it "管理ユーザは他のユーザアカウントの削除ができる" do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'admin@example.com'
      fill_in 'パスワード', with: 'admin_pass'
      click_button 'ログイン'
      visit admin_users_path
      expect(page).to have_text("#{user.email}")
      find("#delete_#{user.id}").click
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_text("ユーザを削除しました")
      expect(page).not_to have_text("#{user.email}")
    end
    it "管理ユーザは他の一般ユーザに管理権限を付与することができる" do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'admin@example.com'
      fill_in 'パスワード', with: 'admin_pass'
      click_button 'ログイン'
      visit admin_users_path
      expect(page).to have_selector("#admin_#{user.id}", text: "false")
      find("#grant_#{user.id}").click
      expect(page).to have_text("管理者権限を付与しました")
      expect(page).to have_selector("#admin_#{user.id}", text: "true")
    end
    it "管理ユーザは他の管理者ユーザの管理権限を抹消することができる" do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'admin@example.com'
      fill_in 'パスワード', with: 'admin_pass'
      click_button 'ログイン'
      visit admin_users_path
      expect(page).to have_selector("#admin_#{new_admin_user.id}", text: "true")
      find("#ensure_#{new_admin_user.id}").click
      expect(page).to have_text("管理者権限を抹消しました")
      expect(page).to have_selector("#admin_#{new_admin_user.id}", text: "false")
    end
    it "管理ユーザが管理権限を持たないゲストアカウントに権限を付与しようとすると拒否される" do
      guest = User.common_guest
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'admin@example.com'
      fill_in 'パスワード', with: 'admin_pass'
      click_button 'ログイン'
      visit admin_users_path
      expect(page).to have_selector("#admin_#{guest.id}", text: "false")
      find("#grant_#{guest.id}").click
      expect(page).to have_text("ゲストアカウントの更新や削除はできません")
      expect(page).to have_selector("#admin_#{guest.id}", text: "false")
    end
    it "管理ユーザが管理権限を持つゲストアカウントの権限を抹消しようとすると拒否される" do
      guest = User.admin_guest
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'admin@example.com'
      fill_in 'パスワード', with: 'admin_pass'
      click_button 'ログイン'
      visit admin_users_path
      expect(page).to have_selector("#admin_#{guest.id}", text: "true")
      find("#ensure_#{guest.id}").click
      expect(page).to have_text("ゲストアカウントの更新や削除はできません")
      expect(page).to have_selector("#admin_#{guest.id}", text: "true")
    end
  end
end
