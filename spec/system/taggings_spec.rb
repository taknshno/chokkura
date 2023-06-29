require "rails_helper"

RSpec.describe "お気に入り機能", type: :system do
  describe "お気に入りの新規登録" do
    include_context "login_setup"
    it "ユーザはスポット一覧画面でお気に入り登録できる" do
      spot = create(:spot, name: 'abc')
      visit spots_path
      find("#fav_#{spot.id}").click
      expect(page).to have_text('スポットをお気に入りに登録しました')
      visit user_path(id: user.id)
      # expect(page).to have_text "abc"
    end
  end
end