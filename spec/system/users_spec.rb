require 'rails_helper'

RSpec.describe 'User', type: :system do
  before { driven_by :rack_test }
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
        expect(page).to have_content('confirmation link')
        expect(current_path).to eq('/') # redirect to top page after sign up
      end
    end
  end

  describe 'Validate login functionality' do
    before do
      create(
        :user, username: username,
               email: email, password: password, password_confirmation: password
      )

      visit '/users/sign_in'
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      click_button 'Login'
    end

    context 'Normal' do
      it 'Succeed to sign in, redirect to top page' do
        expect(current_path).to eq('/')
      end

      it 'Show flash message after sign in' do
        expect(page).to have_content('Signed in successfully')
      end
    end

    context 'Error' do
      before do
        create(
          :user,
          username: username,
          email: email,
          password: '123123',
          password_confirmation: '123123'
        )

        visit '/users/sign_in'

        fill_in 'user_email', with: email
        fill_in 'user_password', with: 'WrongPassword'
        click_button 'Login'
      end
      # let(:password) { 'wrong_password' }
      # it 'Fail to sign in, not redirect to top page' do
      #   expect(current_path).to eq('/users/sign_in')
      # end

      # it 'Show flash message after fail to sign in' do
      #   expect(page).to have_content('Invalid email or password')
      # end
    end
  end
end
