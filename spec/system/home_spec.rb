require 'rails_helper'

describe 'home', type: :system do

  context "トップページが正しく表示される" do
    before do
      visit root_path
    end
    it '非ログイン時の表示' do
      expect(page).to have_content 'ログインする'
    end
    it 'ログイン時の表示' do
      user = FactoryBot.create(:user)
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      expect(page).to have_content 'ゲームを投稿する'
    end
  end

  it 'アバウトページが正しく表示される' do
    visit about_path
    expect(page).to have_content 'ur game'
  end
end