# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern
  included do
    class NotFoundError < StandardError; end
    class UnprocessableEntity < StandardError; end

    rescue_from NotFoundError, ActiveRecord::RecordNotFound do |e|
      render json: { errors: e }, status: :not_found
    end

    rescue_from UnprocessableEntity do |e|
      render json: { errors: e }, status: :unprocessable_entity
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      messages_hash = e.record.errors.messages

      render json: messages_hash, status: :unprocessable_entity
    end
  end
end
