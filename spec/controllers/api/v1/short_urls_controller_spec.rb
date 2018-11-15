# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ShortUrlsController, type: :controller do
  describe 'GET #show' do
    let(:short_url) { create :short_url }
    let(:params) { { id: short_url.uid } }

    it 'Returns original url' do
      get :show, params: params

      expect(response).to have_http_status(:ok)
      # need check format
    end

    it 'Returns not_found' do
      get :show, params: { id: 'wrong_id' }

      expect(response).to have_http_status(:not_found)
      # need check format
    end
  end

  describe 'POST #create' do
    let(:params) { { url: Faker::Internet.url } }

    it 'Create & return short url' do
      post :create, params: params

      expect(response).to have_http_status(:created)
      # need check format
    end

    it 'Create with unprocessable_entity' do
      post :create, params: { url: 'wrong_url_format' }

      expect(response).to have_http_status(:unprocessable_entity)
      # need check format
    end
  end
end
