betterCherkasy.controller 'NewEventCtrl', [
  '$scope', '$location', 'close', 'eventFormDecorator', 'Event'
  ($scope, $location, close, eventFormDecorator, Event) ->
    $scope.timeOptions =
      step: 5
      timeFormat: 'H:i'
    #eventFormDecorator($scope)

    $scope.newEvent = {}

    $scope.add = ->
      alert('add new')
      #$scope.newEvent['auth_token'] = getAuthToken()
      #Event.save($scope.newEvent,
      #(response) ->
      #$location.path('/')
      #)

    $scope.cancel = ->
      $location.path('/')

    $scope.dismissModal = (result) ->
      close result, 10
]
