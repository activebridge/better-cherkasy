betterCherkasy.controller 'EventsCtrl', [
  '$scope', 'Event', '$modal', 'EventUser'
  ($scope, Event, $modal, EventUser) ->

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
      EventUser.update(
        id: event.id
        auth_token: getAuthToken()
        like: true
        , (response) ->
          event.rating = response.rating
      )

    $scope.down = (event) ->
      EventUser.update(
        id: event.id
        auth_token: getAuthToken()
        like: false
        , (response) ->
          event.rating = response.rating
      )

    init()

    $scope.userSignedIn = ->
      userSignedIn()
]

