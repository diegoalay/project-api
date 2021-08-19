Rails.application.routes.draw do
  resources :users do 
    collection do
      get :quantify_characters
      get :duplicated_emails
    end
  end
end
