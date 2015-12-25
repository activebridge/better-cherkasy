Rails.application.config.middleware.use OmniAuth::Builder do
  provider :odnoklassniki, Rails.application.secrets.ok_id, Rails.application.secrets.ok_secret, public_key: Rails.application.secrets.ok_public_key,
    scope: 'VALUABLE_ACCESS'
end

OmniAuth.config.on_failure = OmniauthCallbacksController.action(:failure)
