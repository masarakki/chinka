require 'rails_helper'

describe Eraser do
  before { allow_any_instance_of(Twitter::REST::Client).to receive(:user) { double(id: 100) } }
  describe 'factory' do
    it { expect(build(:eraser)).to be_valid }
  end

  describe 'fill_twitter_id' do
    let(:eraser) { build :eraser, twitter_name: 'masarakki', twitter_id: nil }
    it do
      expect(eraser.user.twitter).to receive(:user).with('masarakki') { double(id: 100) }
      expect(eraser).to be_valid
      expect(eraser.twitter_id).to eq '100'
    end
  end
end
