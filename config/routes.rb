Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :contacts, only: %i(index show destroy)
      scope :contacts, module: 'contacts' do
        resource :uploads, only: :create
      end
    end
  end

  root to: 'static#index'
end
