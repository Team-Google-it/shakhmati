Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "2502626176665599", "1e694e8fa69b6cf193cb1591b0a0961c"
end