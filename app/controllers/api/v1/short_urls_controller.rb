# frozen_string_literal: true

class Api::V1::ShortUrlsController < ApplicationController
  # GET    /api/v1/short_urls/:id
  def show
    render json: { original_url: original_url }
  end

  # POST   /api/v1/short_urls
  def create
    short_url = new_short_url
    render json: { uid: short_url&.uid, original_url: short_url&.original_url }, status: :created
  end

  private

  def original_url
    service = ShortUrlFindService.new(uid: params[:id])
    @original_url ||= service.result if service.call

    raise NotFoundError if @original_url.blank?
  end

  def new_short_url
    service = ShortUrlCreateService.new(original_url: params[:original_url])
    raise ActiveRecord::RecordInvalid, service.result unless service.call

    @new_short_url ||= service.result
  end
end
