# frozen_string_literal: true

class ShortUrlCreateService
  include ActiveModel::Model
  attr_accessor :original_url, :result
  validates :original_url, presence: true
  EXPIRE_TIME = 48.hours

  def call
    return false unless valid?

    store_to_redis if store_to_db
    true
  end

  private

  def store_to_redis
    redis.set(result.uid, result.original_url, ex: EXPIRE_TIME) == 'OK'
  end

  def store_to_db
    self.result = ShortUrl.new(original_url: original_url)
    result.save!
  end

  protected

  def redis
    @redis ||= Redis.new(url: 'redis://localhost:6379/urls')
  end
end
