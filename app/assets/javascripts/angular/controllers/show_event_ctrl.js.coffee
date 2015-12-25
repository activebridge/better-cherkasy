betterCherkasy.controller 'ShowEventCtrl', [
  '$scope', 'Event', '$routeParams', '$sce', 'eventDecorator', '$modal', 'Comment', 'mapDecorator'
  ($scope, Event, $routeParams, $sce, eventDecorator, $modal, Comment, mapDecorator) ->
    eventDecorator($scope)
    mapDecorator($scope)

    $scope.event = {}

    init = ->
      $scope.initGoogleMap('event-map-canvas')
      Event.get {
        id: $routeParams.id
        auth_token: getAuthToken()
      }, (data) ->
        $scope.event = data
        setTimeout ( ->
          $scope.initMagnificPopup()
        ), 300

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

    init()

]
