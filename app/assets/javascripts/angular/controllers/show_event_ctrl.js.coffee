betterCherkasy.controller 'ShowEventCtrl', [
  '$scope', 'Event', '$routeParams', '$sce', 'eventDecorator'
  ($scope, Event, $routeParams, $sce, eventDecorator) ->
    eventDecorator($scope)

    $scope.event = {}

    init = ->
      Event.get {
        id: $routeParams.id
        auth_token: getAuthToken()
      }, (data) ->
        $scope.event = data

    init()

]
