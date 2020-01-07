if Rails.env === 'production' 
  Rails.application.config.session_store :cookie_store, key: 'ace-home', domain: 'uf-ace.com'
else
  Rails.application.config.session_store :cookie_store, key: 'ace-home' 
end