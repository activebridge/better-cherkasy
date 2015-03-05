betterCherkasy.controller 'NavBarCtrl', [
  '$scope', '$facebook', 'AuthService', 'flash', 'Session', '$cookies', '$cookieStore'
  ($scope, $facebook, AuthService, flash, Session, $cookies, $cookieStore) ->

    init = ->
      session = Session.get(id: $cookieStore.get('token'))
      checkCurrentUser(session).then ->
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

    $scope.afterLogIn = ->
      showUserInfo()

    $scope.logOut = ->
      logOut()
      $cookieStore.remove('token')
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
              if response.status is 'OK'
                setCurrentUser(
                  user_id: response.user_id
                  name: response.name
                  avatar_url: response.avatar_url
                )
                $cookieStore.put('token', response.token)
                flash.success = 'Ви залогінились успішно'
                $scope.afterLogIn()
              else
                flash.error = response.message
            ), error = (rs) ->
              console.log rs
              flash.error = 'Чомусь не вдалося залогінитись через facebook'

          ), error = (msg) ->
            flash.error = msg
    init()
]
