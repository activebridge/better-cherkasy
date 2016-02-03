betterCherkasy.controller 'NewCommentCtrl', [
  '$scope'
  'close'
  'event'
  'comment'
  'Comment'
  ($scope, close, event, comment, Comment) ->
    $scope.newComment = {}

    $scope.add = ->
      $scope.newComment['auth_token'] = getAuthToken()
      $scope.newComment['event_id'] = event.id
      $scope.newComment['parent_id'] = comment.id if comment
      Comment.save($scope.newComment, (response) ->
        index = response.index
        data = response.data
        event.comments.splice(index + 1, 0, data)
        $scope.newEvent = {}
        close null, 10
      )

    $scope.dismissModal = (result) ->
      close result, 10
]
