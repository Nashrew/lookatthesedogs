Rails.application.routes.draw do
    resources :dogs do 
       collection do
           get 'random'
       end
    end
    root to: 'dogs#random'
    
    match '/api/random' => 'dogs#random', via: :get, :defaults => { :format => 'json' }
end
