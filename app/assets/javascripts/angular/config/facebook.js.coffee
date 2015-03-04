etcSocialApiKeyConfig = ($facebookProvider, FB_API_KEY) ->
  $facebookProvider.setAppId FB_API_KEY

etcSocialApiKeyConfig.$inject = ['$facebookProvider', 'FB_API_KEY']
betterCherkasy.config etcSocialApiKeyConfig
