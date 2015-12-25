betterCherkasy.factory 'mapDecorator', [
  '$location'
  ($location) ->
    ($scope) ->
      $scope.googleMapReady = false
      $scope.markers = []

      $scope.initGoogleMap = (canvas) ->
        return if $scope.googleMapReady
        myLatlng = new (google.maps.LatLng)(49.4344984, 32.0618366)
        mapOptions =
          zoom: 13
          center: myLatlng
        canvas = document.getElementById(canvas)
        $scope.map = new (google.maps.Map)(canvas, mapOptions)
        $scope.googleMapReady = true
        return

      $scope.placeMarker = (event, centrelize) ->
        location = new (google.maps.LatLng)(event.lat, event.lng)
        infowindow = new (google.maps.InfoWindow)(
          content: event.headline + '</br>' + "<span style='font-size: 9px;'>" + event.address + '</span>'
        )
        marker = new (google.maps.Marker)(
          position: location
          map: $scope.map
          infowindow: infowindow
        )
        if centrelize
          $scope.map.setCenter(location)
        $scope.markers.push marker
        infowindow.open $scope.map, marker
        google.maps.event.addListener marker, 'click', (e) ->
          $scope.$apply ->
            $location.path('/events/' + event.id)
          hidePanel()
          return

      $scope.clearMarkers = ->
        for marker in $scope.markers
          marker.setMap null

      $scope.showAddressOnMap = (event) ->
        $scope.clearMarkers()
        $scope.placeMarker(event, true)
        showPanel('#event-map')
]
