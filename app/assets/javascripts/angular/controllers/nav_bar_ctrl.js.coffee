betterCherkasy.controller 'NavBarCtrl', [
  '$scope', '$facebook',
  ($scope, $facebook) ->

    $scope.loginWithFacebook = ->
      $facebook.login().then (response) ->
        unless (response.authResponse is `undefined` or response.authResponse is null)
          promise = $facebook.cachedApi("/me")
          promise.then (success = (data) ->
            fn = AuthService.loginWithFacebook(data.email, 'facebook', response.authResponse.userID, response.authResponse.accessToken)

            fn.success (result) ->
              if result isnt "" and result isnt `undefined`
                if result.status is "OK"
                  #$rootScope.success_message = I18n.t('js.messages.sign_in_with_fb_successfully')
                  setCurrentUser({auth_token: result.auth_key, role: result.role, user_id: result.user_id})
                  $rootScope.navibarScope.loadTutor()
                  $rootScope.navibarScope.loadRole()
                  $rootScope.messageNavbar.loadMessage()
                  path = (if result.role == 'tutor' then "/hometutor" else "/homestudent")
                  $location.path path
                else
                  flash.error = result.message
              else
                flash.error = I18n.t('js.messages.sign_in_with_fb_fail')
              return

            fn.error (rs) ->
              flash.error = I18n.t('js.messages.sign_in_with_fb_fail')
              return
          ), error = (msg) ->
            flash.error = msg
            return
        return
      return

]
