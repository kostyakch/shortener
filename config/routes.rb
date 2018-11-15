Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, path: '/api' do
    namespace :v1 do
      resources :short_urls, only: [:show, :create]
    end
  end  
end
