betterCherkasy.controller 'NavBarCtrl', [
  '$scope', '$facebook', 'AuthService', 'Flash', 'Session', '$cookies', '$cookieStore', '$window'
  ($scope, $facebook, AuthService, Flash, Session, $cookies, $cookieStore, $window) ->

    $scope.init = ->
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
      $scope.loadVkSdk()

    $scope.logOut = ->
      logOut()
      hideUserInfo()
      if $scope.oauthProvider is 'facebook'
        $facebook.logout()
      else if $scope.oauthProvider is 'vkontakte'
        VK.Auth.logout()

    $scope.loginWithFacebook = ->
      $facebook.login().then (response) ->
        unless (response.authResponse is `undefined` or response.authResponse is null)

          userData =
            providerid: response.authResponse.userID

          promise = $facebook.cachedApi('/me', {fields: 'name, picture'})
          promise.then (success = (data) ->

            userData['name'] = data['name']
            userData['avatar_url'] = data['picture']['data']['url']
            $scope.oauthCallback(userData, 'facebook')
          ), error = (msg) ->
            Flash.create('danger', msg, 'custom-class')

    $scope.loadVkSdk = ->
      $.getScript '//vk.com/js/api/openapi.js', ->
        VK.init
          apiId: gon.vk_client_id

    $scope.loginWithVkontakte = ->
      authInfo = (response) ->
        if response.session
          userData = {}
          userInfo = response.session.user

          VK.Api.call 'users.get',
            uids: userInfo.id
            fields: 'sex, photo_50'
          , (data) ->
            if data.response
              userData['avatar_url'] = data.response[0].photo_50
              userData['name'] = userInfo.first_name + ' '+ userInfo.last_name
              userData['providerid'] = userInfo.id
              $scope.oauthCallback(userData, 'vkontakte')
      VK.Auth.login(authInfo)

    $scope.loginWithOk = ->
      $window.$scope = $scope

      left = screen.width / 2 - 250
      top = screen.height / 2 - 250
      $window.open('/auth/odnoklassniki', '', 'top=' + top + ',left=' + left + ', width=700, height=500')
      return

    $scope.setOkToken = (token)->
      $cookieStore.put('auth_token', token)
      checkCurrentUser().then ->
        flash.success = 'Ви залогінились успішно'
        showUserInfo()
        $scope.oauthProvider = 'odnoklassniki'

    $scope.oauthCallback = (data, provider) ->
      fn = AuthService.doLoginWithSocialNetwork(data, provider)
      fn.$promise.then (success = (response) ->
        if response.status is 'ok'
          $cookieStore.put('auth_token', response.auth_token)
          checkCurrentUser().then ->
            flash.success = 'Ви залогінились успішно'
            showUserInfo()
            $scope.oauthProvider = provider
        else
          flash.error = response.message
      ), error = (rs) ->
        flash.error = 'Чомусь не вдалося залогінитись через ' + provider
]
