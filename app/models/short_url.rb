# frozen_string_literal: true

class ShortUrl < ApplicationRecord
  validates :uid, :url, presence: true, uniqueness: true
  validate :url_should_valid
  before_validation :set_uid

  protected

  def set_uid
    # we can find short url by original if need
    self.uid = Digest::MD5.hexdigest(url) if url.present?
  end

  def url_should_valid
    uri = URI.parse(url)
    raise unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  rescue StandardError
    errors.add(:base, 'wrong url format')
  end
end
