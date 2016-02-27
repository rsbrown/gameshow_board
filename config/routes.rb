Rails.application.routes.draw do
  get 'pages/home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#home'

  get '/answer/:cat_num/:q_num', to: "pages#answer"
  get '/reset', to: "pages#reset"
  get '/edit', to: "pages#edit"
  post '/save', to: "pages#save"

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
