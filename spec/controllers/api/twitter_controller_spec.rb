require 'rails_helper'

RSpec.describe Api::TwitterController, type: :controller do
  let(:user) { create :user }
  before { sign_in user }
  describe 'GET #search' do
    let(:request!) { get :search, params: { q: 'masarakki' }, format: 'json' }
    let(:user_response) { double(id: 1, screen_name: 'a', name: 'b', profile_image_url_https: 'c') }

    it do
      expect_any_instance_of(Twitter::REST::Client).to receive(:user_search).with('masarakki') { [user_response] }
      request!
      expect(assigns(:users).first).to be_a TwitterUser
    end
  end
end
