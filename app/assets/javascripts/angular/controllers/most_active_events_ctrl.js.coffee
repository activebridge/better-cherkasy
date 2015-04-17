betterCherkasy.controller 'MostActiveEventsCtrl', [
  '$scope', 'Event'
  ($scope, Event) ->

    $scope.configs = {showComments: true}
    $scope.events = Event.query {service: 'Events::MostActiveService'}, ->

]

