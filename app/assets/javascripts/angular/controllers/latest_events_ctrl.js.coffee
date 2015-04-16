betterCherkasy.controller 'LatestEventsCtrl', [
  '$scope', 'Event'
  ($scope, Event) ->

    $scope.events = Event.query {service: 'Events::LatestService'}, ->

]

