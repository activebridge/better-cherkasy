betterCherkasy.controller 'MostActiveEventsCtrl', [
  '$scope', 'Event'
  ($scope, Event) ->

    $scope.showTimeStamp = false
    $scope.showComments = true
    $scope.events = Event.query {service: 'Events::MostActiveService'}, ->

]

