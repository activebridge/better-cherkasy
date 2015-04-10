betterCherkasy.controller 'EditEventCtrl', [
  '$scope', 'Event', '$routeParams', 'eventFormDecorator', '$location'
  ($scope, Event, $routeParams, eventFormDecorator, $location) ->
    eventFormDecorator($scope)

    init = ->
      $scope.newEvent = Event.edit {
        id: $routeParams.id
        auth_token: getAuthToken()
      }, (response) ->
        location = new (google.maps.LatLng)(response.lat, response.lng)
        $scope.placeMarker(location)

    init()

    $scope.save = ->
      Event.update(id: $routeParams.id, {event: $scope.newEvent, auth_token: getAuthToken() }
        (response) ->
          $location.path('/events/mine')
      )

    $scope.cancel = ->
      $location.path('/events/mine')
]
