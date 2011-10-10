Rails.application.routes.draw do
  resources :message_requests, :except => [:new, :create]
  resources :message_templates
  resources :messages do
    collection do
      post :destroy_selected
    end
  end
end
