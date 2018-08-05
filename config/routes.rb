Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :available_activities

  get '/available_activities/category/:category', to: 'available_activities#filters', as: :activities_by_category
  get '/available_activities/location/:location', to: 'available_activities#filters', as: :activities_by_location
  get '/available_activities/district/:district', to: 'available_activities#filters', as: :activities_by_district

  get '/available_activities/category/:category/between/:opening_hours', to: 'available_activities#filters', as: :activity_between

end
