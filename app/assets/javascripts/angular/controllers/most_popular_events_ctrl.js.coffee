betterCherkasy.controller 'MostPopularEventsCtrl', [
  '$scope', 'Event'
  ($scope, Event) ->

    $scope.configs =
      showRating: true
      showTabs: true
    $scope.events = Event.query {service: 'Events::MostPopularService', duration: 'week'}, ->

    turnOnOption = (elem) ->
      $('span.option').removeClass('active')
      elem.addClass('active')

    $scope.changeDuration = (duration, $event) ->
      turnOnOption($($event.currentTarget))
      $scope.events = Event.query {service: 'Events::MostPopularService', duration: duration}, ->


]

