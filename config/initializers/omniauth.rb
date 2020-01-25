Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['OMNIAUTH_API_KEY'], ENV['OMNIAUTH_SECRET_KEY']
end