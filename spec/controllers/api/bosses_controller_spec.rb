require 'rails_helper'

RSpec.describe Api::BossesController, type: :controller do
  let(:user) { create :user }
  before { sign_in user }
  describe 'GET #index' do
    let(:request!) { get :index, format: 'json' }
    it do
      boss = double
      expect(controller.current_user).to receive(:bosses) { [boss] }
      request!
      expect(assigns(:bosses)).to eq [boss]
    end
  end

  describe 'POST #create' do
    let(:request!) { post :create, params: { screen_name: 'masarakki' }, format: 'json' }
    let(:boss) { double(id: 1, profile_image_url_https: '', screen_name: 'masarakki', name: '') }
    before { allow(controller.current_user.twitter).to receive(:user) { boss } }
    it do
      expect(controller.current_user.twitter).to receive(:user).with('masarakki') { boss }
      request!
      expect(assigns(:eraser)).to be_a Eraser
    end
    it { expect { request! }.to change { Eraser.count }.by(1) }
  end

  describe 'DELETE #destroy' do
    let!(:eraser) { create :eraser, user: user }
    let(:request!) { delete :destroy, params: { id: eraser.twitter_id }, format: 'json' }
    it do
      expect { request! }.to change { Eraser.count }.by(-1)
    end
  end
end
