require 'rails_helper'

RSpec.describe Api::TweetsController, type: :controller do
  let(:user) { create :user }
  let(:eraser) { create :eraser, twitter_id: user.uid }
  before { sign_in user }

  describe 'GET #index' do
    let(:request!) { get :index, params: { slave_id: eraser.user.uid }, format: 'json' }
    let(:tweet) { double }
    before { allow_any_instance_of(Twitter::REST::Client).to receive(:user_timeline) { [tweet] } }
    it do
      request!
      expect(assigns(:user)).to eq eraser.user
    end
    it do
      request!
      expect(assigns(:tweets)).to eq [tweet]
    end
  end

  describe 'DELETE #destroy' do
    let(:request!) { delete :destroy, params: { slave_id: eraser.user.uid, id: tweet.id }, format: 'json' }
    let(:tweet) { double(id: 1) }
    it do
      expect(controller.current_user).to receive(:destroy_tweet).with(eraser.user, tweet.id)
      request!
    end
  end
end
