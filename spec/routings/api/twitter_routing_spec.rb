require 'rails_helper'

describe Api::TwitterController, type: :routing do
  describe 'routings to #search' do
    it { expect(get: '/api/twitter/search?q=m').to route_to('api/twitter#search', q: 'm', format: 'json') }
    it { expect(api_twitter_search_path(q: 'm')).to eq '/api/twitter/search?q=m' }
  end
end
