Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  scope module: :api, defaults: { format: :json } do
    scope module: :v1 do
      resources :articles, param: :slug, only: [:index, :show, :create, :update, :destroy] do
        get :filter, on: :collection
      end
      resources :tags, only: [:index, :create]
    end
  end
end
