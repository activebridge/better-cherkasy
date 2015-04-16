betterCherkasy.controller 'EventsCtrl', [
  '$scope', 'Event', 'eventDecorator', '$routeParams'
  ($scope, Event, eventDecorator, $routeParams) ->
    eventDecorator($scope)

    init = ->
      filters = {}
      if $routeParams.lat && $routeParams.lng
        filters['lat'] = $routeParams.lat
        filters['lng'] = $routeParams.lng
        filters['radius'] = $routeParams.radius
        filters['service'] = 'Events::ByLocationService'

      $scope.events = Event.query filters, ->


    init()
]

