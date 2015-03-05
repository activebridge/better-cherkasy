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

root.logOut = ->
  root.currentUser = {
    auth_token: ''
    id: ''
    name: ''
    avatar_url: ''
  }

root.checkCurrentUser = (session) ->
  session.$promise.then (success = (data) ->
    root.currentUser = data.user
  ), error = (msg) ->


