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
end
