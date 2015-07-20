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

  describe 'me' do
    let(:user) { create :user, uid: '1' }
    it do
      expect_any_instance_of(Twitter::Cache::Wrapper).to receive(:user).with(1) { double }
      user.me
    end
  end

  describe 'destroy_tweet' do
    let(:boss) { create :user }
    let(:slave) { create :user }
    let(:twitter) { double }
    let(:id) { 1 }
    subject { boss.destroy_tweet(slave, id) }
    before do
      allow(slave).to receive(:twitter) { twitter }
    end
    context 'is not a slave' do
      it do
        expect(twitter).not_to receive(:status)
        expect(subject).to eq false
      end
    end

    context 'is a slave' do
      before { create :eraser, user: slave, twitter_id: boss.uid }
      it do
        expect(twitter).to receive(:status).with(id) { double(full_text: 'hello') }
        expect(twitter).to receive(:destroy_tweet).with(id)
        expect { subject }.to change { RemoveLog.count }.by(1)
      end
    end
  end
end
