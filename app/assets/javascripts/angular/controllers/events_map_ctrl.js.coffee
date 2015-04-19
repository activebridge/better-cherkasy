betterCherkasy.controller 'EventsMapCtrl', [
  '$scope', 'Event', '$location', 'mapDecorator'
  ($scope, Event, $location, mapDecorator) ->
    mapDecorator($scope)

    showEventMarkers = ->
      for event in $scope.events
        if event.address
          $scope.placeMarker(event)

    $scope.init = ->
      $scope.initGoogleMap('events-map-canvas')
      $scope.events = Event.query ->
        showEventMarkers()

]

