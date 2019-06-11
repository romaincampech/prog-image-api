Jets.application.routes.draw do
  get  'images/:id',           to: 'images#show'
  post 'images',               to: 'images#create'
  post 'images/:id/transform', to: 'image_transformations#create'
end
