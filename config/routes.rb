
require 'sidekiq/web'

# Sidekiq::Web.use Rack::Auth::Basic do |username, password|
#   username == BASIC_AUTH_NAME && password == BASIC_AUTH_PASSWORD
# end

Rails.application.routes.draw do
  root to: 'application#home'

  get '/sections/carousel', to: 'application#sections_carousel'
  get '/sections/one',      to: 'application#sections_one'
  get '/sections/:which',   to: 'application#section'

  if defined?( WcoEmail::Engine )
    mount WcoEmail::Engine   => '/email'
  end
  if defined?( WcoHosting::Engine )
    mount WcoHosting::Engine => '/hosting'
  end
  if defined?( Iro::Engine )
    mount Iro::Engine        => '/trading'
  end
  if defined?( Sidekiq::Web )
    mount Sidekiq::Web       => '/sidekiq'
  end
  mount Wco::Engine        => '/wco'

  devise_for :users, controllers: {
  };
  resources :users

end
