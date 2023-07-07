Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '824230818766212', '7cf27a63373a26da72d09d13acb6a31e'
end