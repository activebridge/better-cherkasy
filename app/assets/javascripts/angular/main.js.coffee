root = this

root.setCurrentUser = (currentUser) ->
  root.currentUser =
    auth_token: currentUser.token
    id: currentUser.user_id
    name: currentUser.name
    avatarUrl: currentUser.avatarUrl

root.getCurrentUser = ->
  root.currentUser
