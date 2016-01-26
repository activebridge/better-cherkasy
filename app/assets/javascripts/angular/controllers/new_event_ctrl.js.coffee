betterCherkasy.controller 'NewEventCtrl', [
  '$scope', '$location', '$modalInstance', 'eventFormDecorator', 'Event'
  ($scope, $location, $modalInstance, eventFormDecorator, Event) ->
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

    $scope.close = ->
      $modalInstance.dismiss('cancel')
]
