require 'rails_helper'

describe ErasersController do
  let(:user) { create :user }
  before { sign_in user }

  describe 'GET /' do
    it 'assigns @erasers' do
      eraser = create :eraser, user: user
      get :index
      expect(assigns(:erasers)).to eq [eraser]
    end
  end

  describe 'POST /' do
    context 'valid' do
      before do
        allow_any_instance_of(Twitter::REST::Client).to receive(:user).with('masarakki') { double(id: '123456') }
      end

      it 'assigns @eraser' do
        post :create, eraser: { twitter_name: 'masarakki' }
        eraser = assigns(:eraser)
        expect(eraser).to be_a Eraser
        expect(eraser.user).to eq user
        expect(eraser.twitter_name).to eq 'masarakki'
        expect(eraser.twitter_id).to eq '123456'
        expect(eraser).to be_persisted
      end
    end

    context 'user not found' do
      before do
        allow_any_instance_of(Twitter::REST::Client).to receive(:user).and_raise Twitter::Error::NotFound
      end

      it 'fail' do
        post :create, eraser: { twitter_name: 'masarakki' }
        eraser = assigns(:eraser)
        expect(eraser).to be_a Eraser
        expect(eraser).not_to be_valid
        expect(eraser.twitter_name).to eq 'masarakki'
        expect(eraser.twitter_id).to be_nil
        expect(response).not_to be_success
      end
    end
  end

  describe 'DLETE /:id' do
    let!(:eraser) { create :eraser, user: user }
    it 'assigns @eraser' do
      delete :destroy, id: eraser.to_param
      expect(assigns(:eraser)).to eq eraser
    end
  end
end
