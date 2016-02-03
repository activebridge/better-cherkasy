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

    $scope.openNewCommentModal = ->
      ModalService.showModal(
        templateUrl: '/assets/modals/new_event_comment.html.haml'
        controller: 'NewCommentCtrl'
        inputs:
          event: $scope.event
          comment: {}
      ).then((modal) ->
        modal.element.show()
      )

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
