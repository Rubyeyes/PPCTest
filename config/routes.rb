Rails.application.routes.draw do

  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do

    devise_for :users, :controllers => { :registrations => :registrations }
    
    root to:'home#index'

    resources :admin_setting, only:[:index]
    resources :costs, except:[:show]
    resources :current_user, only:[:index, :edit, :update]
    resources :home, only:[:index]
    resources :instructions
    resources :logos
    resources :notifications, only:[:index, :update, :show, :destroy]
    resources :patents, exept:[:show] do
      collection do
        post :import
      end
    end
    resources :patent_projects, only:[:new, :create, :destroy]
    resources :projects do
      collection do
        post :new_category
        post :new_idea
      end
      member do
        delete :destroy_category
        put :edit_category
        delete :destroy_idea
        put :edit_idea
      end
    end
    resources :products do
      collection do
        post :import
      end
    end
    resources :pos do
      collection do
        post :import
      end
    end
    resources :po_products
    resources :qcstandards
    resources :reports
    resources :role_options
    resources :samples
    resources :status_options
    resources :tasks
    resources :users_admin, :controller => 'users', only:[:index, :edit, :update, :destroy]
    resources :videos

  end

  get '*path', to: redirect("/#{I18n.default_locale}/%{path}")
  get '', to: redirect("/#{I18n.default_locale}")


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
