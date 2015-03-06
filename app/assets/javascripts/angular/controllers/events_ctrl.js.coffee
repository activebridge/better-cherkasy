betterCherkasy.controller 'EventsCtrl', [
  '$scope', 'Event', '$modal'
  ($scope, Event, $modal) ->

    init = ->
      $scope.events = Event.query ->

    $scope.delete = (event_id, index) ->
      if confirm 'Ви впевнені?'
        Event.delete
          id: event_id
          auth_token: getAuthToken()
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

    $scope.up = (event) ->
      event.rating += 1
      Event.update({ id: event.id, auth_token: getAuthToken() }, event)

    $scope.down = (event) ->
      event.rating -= 1
      Event.update({ id: event.id, auth_token: getAuthToken() }, event)

    init()

    $scope.userSignedIn = ->
      userSignedIn()
]

