Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :timecards
      resources :time_entries
      resources :bio_push do
        collection do
          get :push
        end
      end
      resources :test
    end
  end
  resources :bio_push
end
