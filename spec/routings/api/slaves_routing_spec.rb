require 'rails_helper'

describe Api::SlavesController, type: :routing do
  describe 'routings to #index' do
    it { expect(get: '/api/slaves').to route_to('api/slaves#index', format: 'json') }
    it { expect(api_slaves_path).to eq '/api/slaves' }
  end

  describe 'routings to #destroy' do
    it { expect(delete: '/api/slaves/1').to route_to('api/slaves#destroy', id: '1', format: 'json') }
    it { expect(api_slave_path(1)).to eq '/api/slaves/1' }
  end
end
