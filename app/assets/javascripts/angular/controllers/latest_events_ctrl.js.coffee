betterCherkasy.controller 'LatestEventsCtrl', [
  '$scope', 'Event'
  ($scope, Event) ->

    $scope.showTimeStamp = true
    $scope.showComments = false
    $scope.events = Event.query {service: 'Events::LatestService'}, ->

]

