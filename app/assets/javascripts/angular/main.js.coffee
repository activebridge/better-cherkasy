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

root.getAuthToken = ->
  injector().get('$cookieStore').get('auth_token')

root.logOut = ->
  root.currentUser = {
    id: undefined
    name: ''
    avatar_url: ''
  }
  injector().get('$cookieStore').remove('auth_token')

root.checkCurrentUser = ->
  session = injector().get('Session').get(id: root.getAuthToken())
  session.$promise.then (success = (data) ->
    root.currentUser = data
  ), error = (msg) ->
    if root.userSignedIn()
      window.location.href = '/'
