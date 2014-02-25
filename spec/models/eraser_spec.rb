require 'spec_helper'

describe Eraser do
  describe :factory do
    it { expect(build(:eraser)).to be_valid }
  end
end
