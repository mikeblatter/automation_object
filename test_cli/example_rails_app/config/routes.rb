Rails.application.routes.draw do
  get 'user_interface_example/new_window'
  get 'user_interface_example/opened_new_window'

  resources :contacts
  get 'welcome/index'

  root to: 'welcome#index'
end
