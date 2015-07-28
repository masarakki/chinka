require 'rails_helper'

describe Api::TweetsController, type: :routing do
  describe 'routings to #index' do
    it { expect(get: '/api/slaves/1/tweets').to route_to('api/tweets#index', slave_id: '1', format: 'json') }
    it { expect(api_slave_tweets_path(1)).to eq '/api/slaves/1/tweets' }
  end

  describe 'routings to #destroy' do
    it { expect(delete: '/api/slaves/1/tweets/2').to route_to('api/tweets#destroy', slave_id: '1', id: '2', format: 'json') }
    it { expect(api_slave_tweet_path(1, 2)).to eq '/api/slaves/1/tweets/2' }
  end
end
