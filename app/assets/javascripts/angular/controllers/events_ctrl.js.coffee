@EventsCtrl = ['$scope', 'Event', '$modal', ($scope, Event, $modal) ->
  init = ->
    $scope.events = Event.query ->

  $scope.delete = (event_id, index) ->
    Event.delete
      id: event_id
    , (success) ->
        $scope.events.splice(index, 1)
      return

  $scope.openModal = ->
    modalInstance = $modal.open(
      templateUrl: "assets/angular/events/new.html",
      controller: 'NewEventCtrl',
      resolve:
        events: ->
          $scope.events
    )

  init()
]

