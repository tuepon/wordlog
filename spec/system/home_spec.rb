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
end
