'use strict'

betterCherkasy.factory 'AuthService', ['User', (User) ->

  doLoginWithSocialNetwork = (userData, provider) ->
    userData['provider'] = provider
    User.save(userData)

  AuthService =
    loginWithFacebook: (userData) ->
      doLoginWithSocialNetwork userData, 'facebook'

]
