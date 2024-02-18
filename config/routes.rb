Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :applications, param: :token, except: :destroy do
    resources :chats, param: :number, except: :destroy do
      resources :messages, param: :number, except: :destroy
      get '/search', controller: 'messages', action: 'search'
    end
  end

  require 'sidekiq/web'

  mount Sidekiq::Web, at: '/sidekiq'

  Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
    [user, password] == %w[test test]
  end
end
