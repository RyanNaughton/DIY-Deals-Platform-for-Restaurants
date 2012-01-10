Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'xxx', 'xxx'
end
