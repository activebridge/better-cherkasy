betterCherkasy.controller 'NewEventCtrl', [
  '$scope', 'Event', '$location', 'eventFormDecorator', 'flash'
  ($scope, Event, $location, eventFormDecorator, flash) ->
    eventFormDecorator($scope)

    $scope.newEvent = {}

    unless userSignedIn()
      flash.error = 'Для того щоб щось пропонувати ми маєте залогінитись'
      $location.path('/')

    $scope.add = ->
      $scope.newEvent['auth_token'] = getAuthToken()
      Event.save($scope.newEvent,
        (response) ->
          $location.path('/')
      )

    $scope.cancel = ->
      $location.path('/')
]
