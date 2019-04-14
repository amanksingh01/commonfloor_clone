Rails.application.config.middleware.use OmniAuth::Builder do
  
  provider :google_oauth2,
           Rails.application.credentials.dig(:google, :client_id),
           Rails.application.credentials.dig(:google, :client_secret)
  
  provider :facebook,
           Rails.application.credentials.dig(:facebook, :app_id),
           Rails.application.credentials.dig(:facebook, :app_secret)
end