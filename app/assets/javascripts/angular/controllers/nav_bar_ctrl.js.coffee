betterCherkasy.controller 'NavBarCtrl', [
  '$scope', '$facebook', 'AuthService', 'flash'
  ($scope, $facebook, AuthService, flash) ->
    $scope.navBar = {}
    $scope.navBar.showSignInButton = true

    $scope.afterLogIn = ->
      $scope.navBar.showSignInButton = false
      $scope.navBar.userName = getCurrentUser().name
      $scope.navBar.avatarUrl = getCurrentUser().avatarUrl

    $scope.loginWithFacebook = ->

      $facebook.login().then (response) ->
        unless (response.authResponse is `undefined` or response.authResponse is null)

          userData =
            providerid: response.authResponse.userID
            token: response.authResponse.accessToken

          promise = $facebook.cachedApi('/me', {fields: 'name, picture'})
          promise.then (success = (data) ->

            userData['name'] = data['name']
            userData['avatar_url'] = data['picture']['data']['url']

            fn = AuthService.loginWithFacebook(userData)
            fn.$promise.then (success = (response) ->
              if response.status is 'OK'
                setCurrentUser(
                  token: response.token
                  user_id: response.user_id
                  name: response.name
                  avatarUrl: response.avatar_url
                )
                flash.success = 'Ви залогінились успішно'
                $scope.afterLogIn()

              else
                flash.error = response.message
            ), error = (rs) ->
              flash.error = 'Чомусь не вдалося залогінитись через facebook'

          ), error = (msg) ->
            flash.error = msg

]
