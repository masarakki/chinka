require 'rails_helper'

describe Api::UsersController, type: :routing do
  describe 'routings to #me' do
    it { expect(get: '/api/users/me').to route_to('api/users#me', format: 'json') }
    it { expect(api_me_path).to eq '/api/users/me' }
  end
end
