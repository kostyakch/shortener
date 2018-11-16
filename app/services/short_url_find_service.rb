# frozen_string_literal: true

class ShortUrlFindService
  include ActiveModel::Model
  attr_accessor :uid, :short_url, :result
  validates :uid, presence: true
  EXPIRE_TIME = 48.hours

  def call
    return false unless valid?

    self.result = find_url
    true
  end

  private

  def find_url
    res = redis.get(uid)
    return res if res.present?

    # Find from DB
    find_in_db && store_to_redis
    short_url&.original_url
  end

  def find_in_db
    self.short_url = ShortUrl.find_by(uid: uid)
  end

  def store_to_redis
    return if short_url.blank?

    redis.set(short_url.uid, short_url.original_url, ex: EXPIRE_TIME) == 'OK'
  end

  protected

  def redis
    @redis ||= Redis.new(url: 'redis://localhost:6379/urls')
  end
end
