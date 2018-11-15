# frozen_string_literal: true

class Api::V1::ShortUrlsController < ApplicationController
  # GET    /api/v1/short_urls/:id
  def show
    render json: { original_url: short_url&.url }
  end

  # POST   /api/v1/short_urls
  def create
    new_short_url = ShortUrl.new(url: params[:url])
    if new_short_url.save
      render json: { short_url: new_short_url&.url }, status: :created
    else
      raise ActiveRecord::RecordInvalid, new_short_url
    end
  end

  private

  def short_url
    @short_url = ShortUrl.find_by(uid: params[:id])

    raise NotFoundError if @short_url.blank?
  end
end
