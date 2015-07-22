require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  before { sign_in user }

  let(:user) { create :user }

  describe 'GET /me' do
    let(:request!) { get :me, format: 'json' }
    it 'assign current_user' do
      expect(controller.current_user).to receive(:me) { :user }
      request!
      expect(assigns(:user)).to eq :user
    end
  end
end
