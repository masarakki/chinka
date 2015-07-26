require 'rails_helper'

RSpec.describe Api::SlavesController, type: :controller do
  let(:user) { create :user }
  before { sign_in user }

  describe 'GET #index' do
    let(:request!) { get :index, format: 'json' }
    it do
      expect(controller.current_user).to receive(:members) { [user] }
      request!
      expect(assigns(:slaves)).to eq [user]
    end
  end

  describe 'DELETE #destroy' do
    let!(:eraser) { create :eraser, twitter_id: user.uid }
    let(:request!) { delete :destroy, id: eraser.user.uid, format: 'json' }
    it do
      expect { request! }.to change { Eraser.count }.by(-1)
    end
  end
end
