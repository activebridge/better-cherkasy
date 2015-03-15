betterCherkasy.controller 'NewCommentCtrl', [
  '$scope', 'Comment', 'event', '$modalInstance'
  ($scope, Comment, event, $modalInstance) ->
    $scope.newComment = {}

    $scope.add = ->
      $scope.newComment['auth_token'] = getAuthToken()
      $scope.newComment['event_id'] = event.id
      Comment.save($scope.newComment,
        (response) ->
          event.comments.push(response)
          $scope.newEvent = {}
          $modalInstance.dismiss('cancel')
      )

]
