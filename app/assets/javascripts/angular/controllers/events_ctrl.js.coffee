betterCherkasy.controller 'EventsCtrl', [
  '$scope', 'Event', 'eventDecorator'
  ($scope, Event, eventDecorator) ->
    eventDecorator($scope)

    init = ->
      $scope.events = Event.query ->

    init()
]

