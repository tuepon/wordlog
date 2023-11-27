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
      create(:user, nickname: nickname, email: email, password: password, password_confirmation: password)

      visit '/users/sign_in'
      fill_in 'user_email', with: email
      fill_in 'user_password', with: 'password'
      click_button 'Sign In'
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
end
