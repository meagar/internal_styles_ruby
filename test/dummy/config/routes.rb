Rails.application.routes.draw do
  root to: 'tests#cards'

  get '/tests/cards' => 'tests#cards'
  get '/tests/lists' => 'tests#lists'
end
