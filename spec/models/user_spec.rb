require 'rails_helper'

describe User do

  describe 'from twitter' do
    let(:auth) { double(uid: 111_111, info: double(nickname: 'masarakki'), credentials: double(token: 'token', secret: 'secret')) }
    let(:user) { User.from_twitter(auth) }

    shared_examples :user_from_twitter do
      describe 'update from auth' do
        it { expect(user.nick).to eq 'masarakki' }
        it { expect(user.uid).to eq '111111' }
        it { expect(user.access_token).to eq 'token' }
        it { expect(user.secret_token).to eq 'secret' }
      end
    end

    context 'not exists' do
      it_behaves_like :user_from_twitter
    end

    context 'exists' do
      before { User.create uid: 111_111, nick: 'unko', access_token: 'hello', secret_token: 'world' }
      it_behaves_like :user_from_twitter
    end
  end
end
