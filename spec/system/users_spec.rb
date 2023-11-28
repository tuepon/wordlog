require 'rails_helper'

RSpec.describe 'User', type: :system do
  before { driven_by :selenium_chrome_headless }
  # Variable for user input
  let(:email) { 'test@example.com' }
  let(:username) { 'testuser' }
  let(:password) { '123123' }
  let(:password_confirmation) { password }

  describe 'Validate user sign up' do
    before { visit '/users/sign_up' }

    # Summerize each operation for user sign up
    subject do
      fill_in 'user_username', with: username
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', with: password_confirmation
      click_button 'Sign Up'
    end

    context 'Normal' do
      it 'can register user' do
        expect { subject }.to change(User, :count).by(1) # User increments 1
        expect(page).to have_content('User has successfully created')
        expect(current_path).to eq('/') # redirect to top page after sign up
      end
    end
  end

  describe 'Validate login functionality' do
    before do
      create(:user, username: username, email: email, password: password, password_confirmation: password)

      visit '/users/sign_in'
      fill_in 'user_email', with: email
      fill_in 'user_password', with: 'password'
      click_button 'Login'
    end

    context 'Normal' do
      it 'Succeed to sign in, redirect to top page' do
        expect(current_path).to eq('/')
      end

      it 'Show flash message after sign in' do # 追加
        expect(page).to have_content('Signed in successfully')
      end
    end

    context 'Error' do
      let(:password) { 'NGpassword' }
      it 'Fail to sign in, not redirect to top page' do
        expect(current_path).to eq('/users/sign_in')
      end

      it 'Show flash message after fail to sign in' do  # 追加
        expect(page).to have_content('Invalid Email or password')
      end
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
