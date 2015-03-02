@EventsCtrl = ['$scope', 'Event', '$modal', ($scope, Event, $modal) ->
  init = ->
    $scope.events = Event.query ->

  $scope.delete = (event_id, index) ->
    if confirm 'Ви впевнені?'
      Event.delete
        id: event_id
      , (success) ->
          $scope.events.splice(index, 1)

  $scope.openModal = ->
    modalInstance = $modal.open(
      template: $('#new-event-modal').html(),
      controller: 'NewEventCtrl',
      resolve:
        events: ->
          $scope.events
    )

  init()
]

