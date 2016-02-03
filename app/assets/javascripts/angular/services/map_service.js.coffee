'use strict'

betterCherkasy.factory 'MapService', [
  '$routeParams', 'Event', 'eventDecorator', 'mapDecorator'
  ($routeParams, Event, eventDecorator, mapDecorator) ->
    ($scope) ->
      eventDecorator($scope)
      mapDecorator($scope)

      $scope.init = ->
        $scope.scope = 'pending'
        $scope.initGoogleMap('events-map-canvas')
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
        Event.query filters, (response) ->
          for event in response
            if event.address
              $scope.placeMarker event
]
