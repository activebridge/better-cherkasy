betterCherkasy.controller 'MyEventsCtrl', [
  '$scope', 'Event', 'eventDecorator', '$location'
  ($scope, Event, eventDecorator, $location) ->
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

    $scope.edit = (id) ->
      $location.path('/events/' + id + '/edit')

    $scope.isMine = ->
      userSignedIn()

    init()
]

