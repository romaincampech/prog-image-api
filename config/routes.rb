Jets.application.routes.draw do
  post 'upload', to: 'images#upload'
  post 'transform', to: 'images#transform'
end
