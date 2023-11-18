Rails.application.routes.draw do
  resources :reservations, only: %i[ index show create ]
  resources :room_types
  Rails.application.routes.draw do
    devise_for :users, path: '', path_names: {
      sign_in: 'users/sign_in',
      sign_out: 'logout',
      registration: 'signup'
    },
               controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
               }
  end
end
