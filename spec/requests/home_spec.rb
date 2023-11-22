require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  describe 'GET /' do
    it 'should get root' do
      get '/'
      expect(response).to have_http_status(200)
    end
  end
end
