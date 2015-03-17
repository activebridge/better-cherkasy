betterCherkasy.controller 'EventsCtrl', [
  '$scope', 'Event', '$modal', 'eventDecorator'
  ($scope, Event, $modal, eventDecorator) ->
    eventDecorator($scope)

    init = ->
      $scope.events = Event.query ->

    $scope.delete = (event_id, index) ->
      if confirm 'Ви впевнені?'
        Event.delete
          id: event_id
          auth_token: getAuthToken()
        , (success) ->
            $scope.events.splice(index, 1)

    $scope.openModal = (templateUrl)->
      modalInstance = $modal.open
        size: 'lg'
        templateUrl: templateUrl
        controller: 'NewEventCtrl'
        resolve:
          events: ->
            $scope.events

    init()
]

