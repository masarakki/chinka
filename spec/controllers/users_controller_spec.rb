require 'rails_helper'

describe UsersController do
  before { sign_in user }
  before { allow_any_instance_of(User).to receive(:twitter) { twitter } }

  let(:user) { create :user }
  let(:target) { create :user }
  let(:twitter) { double }
  describe 'GET /show' do
    context 'user is a slave' do
      before do
        allow(twitter).to receive(:user_timeline) { [] }
      end
      it 'assign slave as @user' do
        create :eraser, user: target, twitter_id: user.uid
        get :show, id: target.to_param
        expect(assigns(:user)).to eq target
      end
    end

    context 'user is not a slave' do
      it 'assign slave as @user' do
        get :show, id: target.to_param
        expect(response.status).to eq 404
      end
    end
  end

  describe 'DELETE /tweets' do
    context 'user is a slave' do
      before do
        create :eraser, user: target, twitter_id: user.uid
        allow(twitter).to receive(:status) { double(full_text: 'unko') }
        allow(twitter).to receive(:destroy_tweet) { true }
      end
      it 'destroy tweet' do
        expect(twitter).to receive(:destroy_tweet).with(111_111)
        delete :tweets, user_id: target.to_param, id: '111111'
      end

      it 'create remove_log' do
        expect do
          delete :tweets, user_id: target.to_param, id: '111111'
        end.to change { RemoveLog.count }.by(1)
      end
    end
    context 'user is not a slave' do
      it 'assign slave as @user' do
        delete :tweets, user_id: target.to_param, id: '1111111'
        expect(response.status).to eq 404
      end
    end
  end
end
