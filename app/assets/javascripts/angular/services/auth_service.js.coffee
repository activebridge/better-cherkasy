'use strict'

betterCherkasy.factory 'AuthService', ['User', (User) ->

  AuthService =
    doLoginWithSocialNetwork: (userData, provider) ->
      userData['provider'] = provider
      User.save(userData)
]
