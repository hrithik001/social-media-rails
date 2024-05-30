Rails.application.routes.draw do
 root 'posts#index'
 resources :posts
 resources :users, only: [:index, :destroy]
 
 get "edit_password" ,to: "passwords#edit"
 patch "edit_password" ,to: "passwords#update"

 get "sign_up" ,to: "registrations#new"
 post "sign_up" ,to: "registrations#create"

 get 'sign_in' ,to: 'sessions#new'
 post 'sign_in' ,to: 'sessions#create'   
 delete 'sign_out',to: 'sessions#destroy'

 get 'authors' ,to: 'admins#index'
 get 'myposts/:id' ,to: 'myposts#index' , as: "authors_post"

end
