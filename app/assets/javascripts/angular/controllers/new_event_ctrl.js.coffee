betterCherkasy.controller 'NewEventCtrl', [
  '$scope', 'Event', '$location', 'eventFormDecorator'
  ($scope, Event, $location, eventFormDecorator) ->
    eventFormDecorator($scope)

    $scope.newEvent = {}

    $scope.add = ->
      $scope.newEvent['auth_token'] = getAuthToken()
      Event.save($scope.newEvent,
        (response) ->
          $location.path('/')
      )

    $scope.cancel = ->
      $location.path('/')
]
