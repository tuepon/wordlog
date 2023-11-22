require 'rails_helper'

describe User do
  let(:username) { 'testuser' }
  let(:email) { 'test@example.com' }

  describe '.first' do
    before do
      create(:user, username:, email:)
    end

    subject { described_class.first }

    it 'returns user that has been created' do
      expect(subject.username).to eq('testuser')
      expect(subject.email).to eq('test@example.com')
    end
  end
end
