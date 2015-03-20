betterCherkasy.controller 'NewCommentCtrl', [
  '$scope', 'Comment', 'event', '$modalInstance', 'comment'
  ($scope, Comment, event, $modalInstance, comment) ->
    $scope.newComment = {}
    $scope.comment = comment

    $scope.add = ->
      $scope.newComment['auth_token'] = getAuthToken()
      $scope.newComment['event_id'] = event.id
      $scope.newComment['parent_id'] = comment.id if comment
      Comment.save($scope.newComment,
        (response) ->
          index = response.index
          data = response.data
          event.comments.splice(index + 1, 0, data)
          $scope.newEvent = {}
          $modalInstance.dismiss('cancel')
      )

    $scope.close = ->
      $modalInstance.dismiss('cancel')

]
