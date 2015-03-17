betterCherkasy.controller 'NewEventCtrl', [
  '$scope', 'Event', '$modalInstance', 'events', '$http',
  ($scope, Event, $modalInstance, events, $http) ->
    $scope.newEvent = {}

    $scope.options = ->
      {language: 'uk'}

    $scope.loadTags = (query) ->
      $http.get('/tags?query=' + query)

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
