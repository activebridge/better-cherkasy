betterCherkasy.controller 'EventsCtrl', [
  '$scope', 'Event', 'eventDecorator', '$routeParams', 'mapDecorator'
  ($scope, Event, eventDecorator, $routeParams, mapDecorator) ->
    eventDecorator($scope)
    mapDecorator($scope)

    $scope.init = ->
      $scope.initGoogleMap('event-map-canvas')
      filters = {}
      filters['scope'] = $scope.scope
      if $routeParams.lat && $routeParams.lng
        filters['lat'] = $routeParams.lat
        filters['lng'] = $routeParams.lng
        filters['radius'] = $routeParams.radius
        filters['service'] = 'Events::FiltersService'
      if $routeParams.tag
        filters['tag'] = $routeParams.tag
        filters['service'] = 'Events::FiltersService'
      $scope.events = Event.query filters, ->
        setTimeout ( ->
          $scope.initMagnificPopup()
        ), 300

    $scope.initPending()
]

