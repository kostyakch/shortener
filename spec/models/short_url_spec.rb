# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  describe 'Url Should' do
    it 'be valid' do
      expect(ShortUrl.new(url: 'http://test.com')).to be_valid
    end

    it 'mot valid' do
      expect(ShortUrl.new).not_to be_valid
    end

    it 'mot valid with wrong url format' do
      expect(ShortUrl.new(url: 'test_string')).not_to be_valid
    end
  end
end
