betterCherkasy.controller 'FiltersCtrl', [
  '$scope'
  ($scope) ->
    $scope.currentLocation = null
    $scope.googleMapReady = false

    initGoogleMap = ->
      return if $scope.googleMapReady
      myLatlng = new (google.maps.LatLng)(49.4344984, 32.0618366)
      mapOptions =
        zoom: 13
        center: myLatlng
      canvas = document.getElementById('map-canvas')
      map = new (google.maps.Map)(canvas, mapOptions)
      google.maps.event.addListener map, 'click', (event) ->
        $scope.placeMarker event.latLng
      $scope.googleMapReady = true
      return

    fetchCurrentGeoLocation = ->
      if navigator.geolocation
        navigator.geolocation.getCurrentPosition (position) ->
          latlng = new (google.maps.LatLng)(position.coords.latitude, position.coords.longitude)
          geocoder = new (google.maps.Geocoder)
          geocoder.geocode { 'latLng': latlng, 'language': 'ua' }, (results, status) ->
            if status == google.maps.GeocoderStatus.OK
              $scope.currentLocation = results[0].formatted_address
              $('#slide-down-panel img').hide()
              $scope.$apply()
      else
        $scope.currentLocation = 'Geolocation is not supported by this browser.'
      return

    init = ->
      fetchCurrentGeoLocation()

    init()

    $scope.showMap = ->
      initGoogleMap()
      $('.map-container').slideDown(1000)
      return

    $scope.nearMe = ->
      $('.map-container').slideUp(1000)
      return

]

