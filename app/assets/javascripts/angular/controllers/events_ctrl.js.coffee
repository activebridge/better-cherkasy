@EventsCtrl = ['$scope', '$q', 'Event', ($scope, $q, Event) ->
  $scope.newEvent = {}
  $scope.events = Event.query ->

  $scope.add = ->
    Event.save($scope.newEvent,
      (response) ->
        $scope.events.push(response.event)
        $scope.newEvent = {}
    )

  $scope.delete = (event_id, index) ->
    Event.delete
      id: event_id
    , (success) ->
        $scope.events.splice(index, 1)
      return

]

