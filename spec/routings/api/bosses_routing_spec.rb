require 'rails_helper'

describe Api::BossesController, type: :routing do
  describe 'routings to #index' do
    it { expect(get: '/api/bosses').to route_to('api/bosses#index', format: 'json') }
    it { expect(api_bosses_path).to eq '/api/bosses' }
  end
end
