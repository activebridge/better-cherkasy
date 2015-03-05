root = this

root.currentUser = {}

root.setCurrentUser = (currentUser) ->
  root.currentUser =
    auth_token: currentUser.token
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
    auth_token: ''
    id: undefined
    name: ''
    avatar_url: ''
  }
  token = injector().get('$cookieStore').remove('token')

root.checkCurrentUser = ->
  token = injector().get('$cookieStore').get('token')
  session = injector().get('Session').get(id: token)
  session.$promise.then (success = (data) ->
    root.currentUser = data.user
  ), error = (msg) ->
    if root.userSignedIn()
      window.location.href = '/'
