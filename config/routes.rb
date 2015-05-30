VizDoc::Engine.routes.draw do
  get "logs/show" => "logs#show"
  get "index" => "logs#index"
end
