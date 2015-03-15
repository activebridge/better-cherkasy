betterCherkasy.controller 'ShowEventCtrl', [
  '$scope', 'Event', '$routeParams', '$sce', 'eventDecorator', '$modal'
  ($scope, Event, $routeParams, $sce, eventDecorator, $modal) ->
    eventDecorator($scope)

    $scope.event = {}

    init = ->
      Event.get {
        id: $routeParams.id
        auth_token: getAuthToken()
      }, (data) ->
        $scope.event = data

    $scope.openModal = (templateUrl)->
      modalInstance = $modal.open
        templateUrl: templateUrl
        controller: 'NewCommentCtrl'
        resolve:
          event: ->
            $scope.event

    init()

]
