Rails.application.routes.draw do
  get '/tests/cards' => 'tests#cards'
  get '/tests/lists' => 'tests#lists'
end
