Gradappsys::Application.routes.draw do

  match '/auth/:provider/callback' => 'authentications#create'
  match "/users_registrations/account_setup" => "user_registrations#account_setup", :as => "account_setup"
  
  resources :contactus, :only => [:new, :index, :create]
  resources :questions
  resources :authentications, :only => [ :index, :create, :destroy ]
  #resources :topics
  match "/topics/follow_topic" => "topics#follow_topic"
  match "/topics/unfollow_topic" => "topics#unfollow_topic"
  
  #links related routes
  resources :links
  match "/l_increase_rating" => "links#l_increase_rating", :as => "l_increase_rating", :method => "get"
  match "/l_decrease_rating" => "links#l_decrease_rating", :as => "l_decrease_rating", :method => "get"
  
  match "/aboutus" => "company#aboutus"
  match "/contactus" => "company#contactus"
  
  #questions related routes
  match "/questions/post_answer" => "questions#post_answer"
  match "/questions/update_answer" => "questions#update_answer"
  match "/questions/delete_answer" => "questions#delete_answer"
  match "/questions/add_comment" => "questions#add_comment"
  match "/questions/get_questions" => "questions#get_questions"
  match "/questions/open_question" => "questions#open_question"
  match "/questions/top_questions" => "questions#top_questions"
  match "/questions/load_related_stuff" => "questions#load_related_stuff"
  match "/questions/set_flag" => "questions#set_flag"
  match "/questions/follow" => "questions#follow"
  match "/q_increase_rating" => "questions#q_increase_rating", :as => "q_increase_rating", :method => "get"
  match "/q_decrease_rating" => "questions#q_decrease_rating", :as => "q_decrease_rating", :method => "get"
  match "/a_increase_rating" => "questions#a_increase_rating", :as => "a_increase_rating", :method => "get"
  match "/a_decrease_rating" => "questions#a_decrease_rating", :as => "a_decrease_rating", :method => "get"
  
  #links related routes
  match "/links/post_comment" => "links#post_comment"
  match "/links/load_related_stuff" => "links#load_related_stuff"
  match "/links/get_links" => "links#get_links"
  match "/links/top_links" => "links#top_links"
  match "/links/set_flag" => "links#set_flag"
  
  match "/apps/get_apps" => "apps#get_apps"
  
  #search related routes
  match "search" => "search#index"
  match "/search/load_more_questions" => "search#load_more_questions"
  match "/search/load_more_links" => "search#load_more_links"
  
  #profile related routes
  devise_for :users, :controllers => { :registrations => 'user_registrations'}  do
     get "home", :to => "devise/registrations#new"
     get "/profile/:id" => "user_registrations#show",:as => :show_profile 
     get '/facebook' => "user_registrations#facebook", :as => :facebook_login
     get "/user_registrations/add_description" => "user_registrations#add_description"     
     match "/user_registrations/upload_photo" => "user_registrations#upload_photo", :as => :upload_photo, :method => "put"
     match "/user_registrations/user_photo" => "user_registrations#user_photo", :as => :user_photo, :method => "get"     
  end
  
  resources :apps
  resources :contact_people
  resources :feedbacks, :only => [:index, :create]
  
  match '/new_update' => "apps#new_update", :as => :new_update
  
  root :to => "questions#index"
end
