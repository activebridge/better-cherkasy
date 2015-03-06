betterCherkasy.controller 'NavBarCtrl', [
  '$scope', '$facebook', 'AuthService', 'flash', 'Session', '$cookies', '$cookieStore'
  ($scope, $facebook, AuthService, flash, Session, $cookies, $cookieStore) ->

    init = ->
      checkCurrentUser().then ->
        $scope.navBar = {}
        if userSignedIn()
          showUserInfo()
        else
          hideUserInfo()

    showUserInfo = ->
      $scope.navBar.showSignInButton = false
      $scope.navBar.userName = getCurrentUser().name
      $scope.navBar.avatarUrl = getCurrentUser().avatar_url

    hideUserInfo = ->
      $scope.navBar.showSignInButton = true
      $scope.navBar.userName = ''
      $scope.navBar.avatarUrl = ''

    $scope.logOut = ->
      logOut()
      hideUserInfo()

    $scope.loginWithFacebook = ->
      $facebook.login().then (response) ->
        unless (response.authResponse is `undefined` or response.authResponse is null)

          userData =
            providerid: response.authResponse.userID

          promise = $facebook.cachedApi('/me', {fields: 'name, picture'})
          promise.then (success = (data) ->

            userData['name'] = data['name']
            userData['avatar_url'] = data['picture']['data']['url']

            fn = AuthService.loginWithFacebook(userData)
            fn.$promise.then (success = (response) ->
              if response.status is 'ok'
                $cookieStore.put('auth_token', response.auth_token)
                checkCurrentUser().then ->
                  flash.success = 'Ви залогінились успішно'
                  showUserInfo()
              else
                flash.error = response.message
            ), error = (rs) ->
              flash.error = 'Чомусь не вдалося залогінитись через facebook'

          ), error = (msg) ->
            flash.error = msg
    init()
]
