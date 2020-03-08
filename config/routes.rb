Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/accounts/status', to: 'gt_metrix_accounts#account_info'

  post '/tests/create', to: 'gt_metrix_tests#create_test'
  get '/tests', to: 'gt_metrix_tests#tests'
end
