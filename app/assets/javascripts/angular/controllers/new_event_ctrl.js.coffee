betterCherkasy.controller 'NewEventCtrl', [
  '$scope', 'Event', '$modalInstance', 'events',
  ($scope, Event, $modalInstance, events) ->
    $scope.newEvent = {}

    $scope.add = ->
      $scope.newEvent['auth_token'] = getAuthToken()
      Event.save($scope.newEvent,
        (response) ->
          events.push(response)
          $scope.newEvent = {}
          $modalInstance.dismiss('cancel')
      )


    setTimeout ( ->
      $('.timepicker').timepicker
        minuteStep: 5

      $('.datepicker').datepicker
        autoclose: true
        todayHighlight: true
        startDate: new Date()
        format: 'dd-mm-yyyy'
    ), 300

]
