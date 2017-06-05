Rails.application.routes.draw do
  get 'game/score', to: "game#score"

  get 'game/words', to: "game#words"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
