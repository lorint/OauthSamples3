Rails.application.routes.draw do

  get 'social_media/facebook'
  get 'social_media/twitter'
  get 'social_media/soundcloud'
  get 'social_media/github'
  get 'social_media/linkedin'
  get 'social_media/google'
  get 'social_media/myspace'
  get 'social_media/bebo'
  get 'social_media/flicker'
  get 'social_media/pinterest'
  get 'social_media/instagram'
  get 'social_media/reddit'
  get 'social_media/snapchat'
  get 'social_media/mixcloud'
  get 'social_media/apple'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "home#index", as: :home
end
