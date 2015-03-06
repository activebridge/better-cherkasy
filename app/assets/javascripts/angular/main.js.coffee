root = this

root.currentUser = {}

root.setCurrentUser = (currentUser) ->
  root.currentUser =
    id: currentUser.user_id
    name: currentUser.name
    avatar_url: currentUser.avatar_url

root.getCurrentUser = ->
  root.currentUser

root.userSignedIn = ->
  root.currentUser.id != undefined

injector = ->
  angular.element(document).injector()

root.logOut = ->
  root.currentUser = {
    id: undefined
    name: ''
    avatar_url: ''
  }
  injector().get('$cookieStore').remove('auth_token')

root.checkCurrentUser = ->
  auth_token = injector().get('$cookieStore').get('auth_token')
  session = injector().get('Session').get(id: auth_token)
  session.$promise.then (success = (data) ->
    root.currentUser = data.user
  ), error = (msg) ->
    if root.userSignedIn()
      window.location.href = '/'
