@NewEventCtrl = ['$scope', 'Event', '$modalInstance', 'events', ($scope, Event, $modalInstance, events) ->
  $scope.newEvent = {}

  $scope.add = ->
    Event.save($scope.newEvent,
      (response) ->
        events.push(response.event)
        $scope.newEvent = {}
        $modalInstance.dismiss('cancel')
    )
]
