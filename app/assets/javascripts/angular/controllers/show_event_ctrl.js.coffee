betterCherkasy.controller 'ShowEventCtrl', [
  '$scope'
  'close'
  'event_id'
  'MapService'
  'ModalService'
  'Comment'
  ($scope, close, event_id, MapService, ModalService, Comment) ->
    $scope.event_id = event_id
    $scope.event = {}
    angular.extend($scope, MapService($scope))

    $scope.openNewCommentModal = ->
      ModalService.showModal(
        templateUrl: '/assets/modals/new_event_comment.html.haml'
        controller: 'NewCommentCtrl'
        inputs:
          event: $scope.event
          comment: null
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

    $scope.openReplyModal = (comment, index) ->
      ModalService.showModal(
        templateUrl: '/assets/modals/new_event_comment.html.haml'
        controller: 'NewCommentCtrl'
        inputs:
          event: $scope.event
          comment: comment
      ).then((modal) ->
        modal.element.show()
      )

    $scope.dismissModal = (result) ->
      close result, 10

    $scope.showEventInit()
]
