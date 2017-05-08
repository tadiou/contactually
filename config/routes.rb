Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :contacts, only: [:index, :show, :destroy]
      scope module: 'contacts' do
        resource :upload, only: :create
      end
    end
  end
end
