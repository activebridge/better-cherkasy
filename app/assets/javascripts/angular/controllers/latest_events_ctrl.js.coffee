betterCherkasy.controller 'LatestEventsCtrl', [
  '$scope', 'Event'
  ($scope, Event) ->

    $scope.configs = {showTimeStamp: true}
    $scope.events = Event.query {service: 'Events::LatestService'}, ->

]

