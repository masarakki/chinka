require 'rails_helper'

describe Api::UsersController, type: :routing do
  describe 'routings to #show' do
    it { expect(get: '/api/user').to route_to('api/users#show', format: 'json') }
    it { expect(api_user_path).to eq '/api/user' }
  end
end
