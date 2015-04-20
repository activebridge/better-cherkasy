betterCherkasy.controller 'EventsCtrl', [
  '$scope', 'Event', 'eventDecorator', '$routeParams', 'mapDecorator'
  ($scope, Event, eventDecorator, $routeParams, mapDecorator) ->
    eventDecorator($scope)
    mapDecorator($scope)

    $scope.showAddressOnMap = (event) ->
      $scope.clearMarkers()
      $scope.placeMarker(event, true)
      showPanel('#event-map')

    $scope.onFileSelect = ($files) ->
      console.log 'helllo'

    $scope.upload = ($files) ->
      console.log 'upload'
      i = 0
      while i < $files.length
        file = $files[i]
        $upload.upload (
          url: 'url'
          file: file
        ).progress((evt) ->

        ).success (data, status, headers, config) ->
          return


    init = ->
      $scope.initGoogleMap('event-map-canvas')
      filters = {}
      if $routeParams.lat && $routeParams.lng
        filters['lat'] = $routeParams.lat
        filters['lng'] = $routeParams.lng
        filters['radius'] = $routeParams.radius
        filters['service'] = 'Events::FiltersService'
      if $routeParams.tag
        filters['tag'] = $routeParams.tag
        filters['service'] = 'Events::FiltersService'


    init()
]

