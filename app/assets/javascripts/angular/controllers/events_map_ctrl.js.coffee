betterCherkasy.controller 'EventsMapCtrl', [
  '$scope', 'Event', '$location'
  ($scope, Event, $location) ->
    $scope.googleMapReady = false

    initGoogleMap = ->
      return if $scope.googleMapReady
      myLatlng = new (google.maps.LatLng)(49.4344984, 32.0618366)
      mapOptions =
        zoom: 13
        center: myLatlng
      canvas = document.getElementById('events-map-canvas')
      $scope.map = new (google.maps.Map)(canvas, mapOptions)
      $scope.googleMapReady = true
      return

    placeMarker = (event) ->
      location = new (google.maps.LatLng)(event.lat, event.lng)
      infowindow = new (google.maps.InfoWindow)(
        content: event.headline + '</br>' + "<span style='font-size: 9px;'>" + event.address + '</span>'
      )
      marker = new (google.maps.Marker)(
        position: location
        map: $scope.map
        infowindow: infowindow
      )
      infowindow.open $scope.map, marker
      google.maps.event.addListener marker, 'click', (e) ->
        $scope.$apply ->
          $location.path('/events/' + event.id)
        hidePanel()
        return

    showEventMarkers = ->
      for event in $scope.events
        if event.address
          placeMarker(event)

    $scope.init = ->
      initGoogleMap()
      $scope.events = Event.query ->
        showEventMarkers()


    #init()
]

