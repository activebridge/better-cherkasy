betterCherkasy.controller 'ShowEventCtrl', [
  '$scope'
  '$routeParams'
  '$sce'
  'close'
  'event_id'
  'MapService'
  'ModalService'
  'Comment'
  ($scope, $routeParams, $sce, close, event_id, MapService, ModalService, Comment) ->
    $scope.event_id = event_id
    $scope.event = {}
    angular.extend($scope, MapService($scope))

    $scope.openNewCommentModal = (templateUrl)->
      $modal.open
        templateUrl: templateUrl
        controller: 'NewCommentCtrl'
        resolve:
          event: ->
            $scope.event
          comment: ->

    $scope.deleteComment = (comment_id, index) ->
      if confirm 'Ви впевнені?'
        Comment.delete
          event_id: $scope.event.id
          id: comment_id
          auth_token: getAuthToken()
        , (success) ->
            $scope.event.comments.splice(index, 1)

    $scope.openReplyModal = (templateUrl, comment, index) ->
      $modal.open
        templateUrl: templateUrl
        controller: 'NewCommentCtrl'
        resolve:
          event: ->
            $scope.event
          comment: ->
            comment

    $scope.dismissModal = (result) ->
      close result, 10

    $scope.showEventInit()
]
