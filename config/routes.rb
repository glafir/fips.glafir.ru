Fips::Application.routes.draw do
  resources :orgs do
    resources :org_addresses
    resources :org_telefphones
    resources :tz_requests do
      resources :fips_tzs do
        member do
          get "create_docx" => "fips_tzs#create_docx", format: 'docx'
        end
      end
    end
  end
#  netzke
  devise_for :users, :controllers => {
    :sessions => "users/sessions",
    :registrations => "users/registrations"
  }
  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "users/sign_out", :to => "users/sessions#destroy"
    delete "users/sign_out", :to => "users/sessions#destroy"
    root "users/sessions#new"
  end

  scope "/admin" do
    resources :users
  end


  resources :proxies
  resources :fips_tzs do
    member do
      get "create_docx" => "fips_tzs#create_docx", format: 'docx'
    end
  end
  get "/noko/:id" => "fips_tzs#noko", as: :fips_noko
  get "/update_all" => "fips_tzs#update_all"
  get "/fips/:id" => "fips_tzs#fips_show"
  get "/update_tz/:id" => "fips_tzs#update_tz"
  get "fips_adm" => "fips_tzs#fips_adm"
  get "home/index"
  get "home/kachalka"
  get "/tz_number_generate" => "fips_tzs#tz_number_generate"
  post "/tz_number_generate" => "fips_tzs#tz_number_generate"
  get "/proxy_load" => "proxies#proxy_load"
  get "/proxy_check" => "proxies#proxy_check"
  get "/fips_kachalka" => "proxies#fips_kachalka"
  get "/check" => "proxies#check"
end
