# Be sure to restart your server when you modify this file.
Rails.application.config.session_store :cookie_store, key: '_academico_session'
#Rails.application.config.session_store :cookie_store , key: '_academico_session_' #, secure: (Rails.env.production? || Rails.env.staging?)
Academico::Application.config.session_store :cookie_store, :key => '_academico_session', 
  :expire_after => 30.minutes
