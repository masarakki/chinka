require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  let(:user) { create :user }
  before { sign_in user }

  describe 'GET /show' do
    let(:request!) { get :show, format: 'json' }
    it 'assign current_user' do
      expect(controller.current_user).to receive(:me) { :user }
      request!
      expect(assigns(:user)).to eq :user
    end
  end
end
