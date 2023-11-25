require 'rails_helper'

describe User do
  let(:username) { 'testuser' }
  let(:email) { 'test@example.com' }

  describe '.first' do
    before do
      create(:user, username: username, email: email)
    end

    subject { described_class.first }

    it 'returns user that has been created' do
      expect(subject.username).to eq('testuser')
      expect(subject.email).to eq('test@example.com')
    end
  end

  describe 'validation' do
    describe 'username property' do
      describe 'validate char length'
        context 'username is less than 20 chars' do
          let(:username) { 'abcdefghijklmnopqrst' } # 20chars

          it 'User object is valid' do
            expect(user.valid?).to be(true)
          end
        end

        context 'username is more than 20 chars' do
          let(:username) { 'abcdefghijklmnopqrstu' } # 21chars

          it 'User object is invalid' do
            user.valid?

            expect(user.valid?).to be(false)
            expect(user.errors[:username]).to include('is too long (maximum is 20 characters)')
          end
        end
      end
    end
  end
end
