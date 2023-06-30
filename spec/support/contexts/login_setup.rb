RSpec.shared_context "admin_login_setup" do
  let!(:admin_user) { create(:admin_user) }
  before do
    visit new_user_session_path
    fill_in "メールアドレス", with: "steve@example.com"
    fill_in "パスワード", with: "12345678"
    click_button "ログイン"
  end
end

RSpec.shared_context "login_setup" do
  let!(:user) { create(:user) }
  before do
    visit new_user_session_path
    fill_in "メールアドレス", with: "david@example.com"
    fill_in "パスワード", with: "12345678"
    click_button "ログイン"
  end
end