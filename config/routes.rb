Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :contacts, only: [:index, :show, :destroy]
      scope :contacts, module: 'contacts' do
        resource :uploads, only: :create
      end
    end
  end
end
