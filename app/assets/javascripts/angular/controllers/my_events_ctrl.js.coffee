betterCherkasy.controller 'MyEventsCtrl', [
  '$scope', 'Event', 'eventDecorator'
  ($scope, Event, eventDecorator) ->
    eventDecorator($scope)

    init = ->
      $scope.events = Event.query
        id: 'mine'
        auth_token: getAuthToken()

    $scope.delete = (event_id, index) ->
      if confirm 'Ви впевнені?'
        Event.delete
          id: event_id
          auth_token: getAuthToken()
        , (success) ->
            $scope.events.splice(index, 1)

    $scope.isMine = ->
      userSignedIn()

    init()
]

