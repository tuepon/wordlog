require 'rails_helper'

RSpec.describe 'Home', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'validate index page' do
    it 'shows Home#index' do
      visit '/'

      expect(page).to have_content('Home#index')
    end
  end

  describe 'Validate navbar' do
    context 'When not login' do
      before { visit '/' }

      it 'Show link to register' do
        expect(page).to have_link('Sign Up', href: '/users/sign_up')
      end

      it 'Show link to login' do
        expect(page).to have_link('Login', href: '/users/sign_in')
      end

      it 'Not show link to logout' do
        expect(page).not_to have_content('Logout')
      end
    end

    context 'When logged in' do
      before do
        user = create(:user) # ログイン用のユーザーを作成
        sign_in user # 作成したユーザーでログイン
        visit '/'
      end

      it 'Not show link to sign up' do
        expect(page).not_to have_link('Sign Up', href: '/users/sign_up')
      end

      it 'Not show link to login' do
        expect(page).not_to have_link('Login', href: '/users/sign_in')
      end

      it 'Show link to logout' do
        expect(page).to have_content('Logout')
      end

      it 'Link to logout works' do
        click_button 'Logout'

        # ログインしていない状態のリンク表示パターンになることを確認
        expect(page).to have_link('Sign Up', href: '/users/sign_up')
        expect(page).to have_link('Login', href: '/users/sign_in')
        expect(page).not_to have_content('Logout')
      end
    end
  end
end
