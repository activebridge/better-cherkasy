@NewEventCtrl = ['$scope', 'Event', '$rootScope', '$modalInstance', ($scope, Event, $rootScope, $modalInstance) ->
  $scope.newEvent = {}

  $scope.add = ->
    Event.save($scope.newEvent,
      (response) ->
        $rootScope.eventsController.events.push(response.event)
        $scope.newEvent = {}
        $modalInstance.dismiss('cancel')
    )
]
