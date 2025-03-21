# frozen_string_literal: true

Rails.application.routes.draw do
  resources :passengers
  resources :drivers

  # Shift, get one certain driver's id, return all related shifts
  get "driver_all_shifts", to: "shifts#driver_all_shifts", as: "driver_all_shifts"

  # Shift, Shift Calendar's Read-only view for drivers
  get "read_only_shifts", to: "shifts#readonly_index", as: "read_only_shifts"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "rides#filter"

  resources :rides do
    collection do
      get "today"
      get "filter"
      get "filter_results"
    end
  end

  resources :shifts do
    member do
      get "feedback"
    end
  end
end
