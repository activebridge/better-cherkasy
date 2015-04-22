betterCherkasy.controller 'MyEventsCtrl', [
  '$scope', 'Event', 'eventDecorator', '$location', '$upload'
  ($scope, Event, eventDecorator, $location, $upload) ->
    eventDecorator($scope)

    $scope.myEvents = true

    $scope.upload = ($files, event) ->
      i = 0
      while i < $files.length
        file = $files[i]
        $upload.upload(
          url: '/events/' + event.id + '/photos?auth_token=' + getAuthToken()
          file: file
        ).progress((evt) ->
        ).success((data, status, headers, config) ->
          event.photos.push data
        ).error( ->
          console.log 'error'
          return
        )
        i++

    $scope.init = ->
      $scope.events = Event.query
        id: 'mine'
        auth_token: getAuthToken()
        scope: $scope.scope
        , (success) ->
          setTimeout ( ->
            $scope.initMagnificPopup()
          ), 300

    $scope.delete = (event_id, index) ->
      if confirm 'Ви впевнені?'
        Event.delete
          id: event_id
          auth_token: getAuthToken()
        , (success) ->
            $scope.events.splice(index, 1)

    $scope.completeEvent = (event) ->
      Event.update(id: event.id, {event: {completed: true}, auth_token: getAuthToken() }
        (response) ->
          $scope.init()
      )


    $scope.edit = (id) ->
      $location.path('/events/' + id + '/edit')

    $scope.isMine = ->
      userSignedIn()

    $scope.initPending()
]

