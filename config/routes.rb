  Rails.application.routes.draw do
    resources :reservations, only: %i[ index show create ] do
      put :cancel, on: :member

    end
    resources :room_types

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
