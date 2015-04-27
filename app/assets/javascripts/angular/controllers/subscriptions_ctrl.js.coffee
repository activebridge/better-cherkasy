betterCherkasy.controller 'SubscriptionsCtrl', [
  '$scope', 'Event', 'eventDecorator'
  ($scope, Event, eventDecorator) ->
    eventDecorator($scope)

    $scope.init = ->
      $scope.events = Event.query
        id: 'subscriptions'
        auth_token: getAuthToken()
        scope: $scope.scope
        , (success) ->
          setTimeout ( ->
            $scope.initMagnificPopup()
          ), 300

    $scope.initPending()
]

