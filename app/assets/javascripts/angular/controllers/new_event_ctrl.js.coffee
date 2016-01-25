betterCherkasy.controller 'NewEventCtrl', [
  '$scope', 'Event', '$location', 'eventFormDecorator', 'Flash'
  ($scope, Event, $location, eventFormDecorator, Flash) ->
    eventFormDecorator($scope)

    $scope.newEvent = {}

    unless userSignedIn()
      Flash.create('warning', 'Для того щоб щось пропонувати ви маєте залогінитись', 'custom-class')
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
