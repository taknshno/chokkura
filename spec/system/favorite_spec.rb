require "rails_helper"

RSpec.describe "お気に入り機能", type: :system do
  describe "お気に入りの新規登録" do
    include_context "login_setup"
    it "ユーザはスポット一覧画面でお気に入り登録できる" do
      spot = create(:spot, name: 'abc')
      visit spots_path
      find("#fav_#{spot.id}").click
      expect(page).to have_text('スポットをお気に入りに登録しました')
      expect(page).to have_css("#faved_#{spot.id}")
    end
  end

  describe "お気に入りの登録解除" do
    include_context "login_setup"
    it "ユーザはスポット一覧画面で登録済みのお気に入りを解除できる" do
      spot = create(:spot)
      create(:favorite, user: user, spot: spot)
      visit spots_path
      expect(page).to have_css("#faved_#{spot.id}")
      find("#unfav_#{spot.id}").click
      expect(page).to have_text('スポットのお気に入りを解除しました')
      expect(page).to have_css("#unfaved_#{spot.id}")
    end
  end

  describe "お気に入りの一覧表示" do
    include_context "login_setup"
    it "ユーザはユーザ詳細画面でお気に入り登録したスポットを一覧表示できる" do
      spot1 = create(:spot, name: 'abc')
      spot2 = create(:spot, name: 'xyz')
      create(:favorite, user: user, spot: spot1)
      create(:favorite, user: user, spot: spot2)
      visit user_path(id: user.id)
      expect(page).to have_text('abc')
      expect(page).to have_text('xyz')
    end
  end
end