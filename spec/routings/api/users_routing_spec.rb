require 'rails_helper'

describe Api::UsersController, type: :routing do
  describe 'routings to #me' do
    it { expect(get: '/api/me').to route_to('api/users#me', format: 'json') }
  end
end
