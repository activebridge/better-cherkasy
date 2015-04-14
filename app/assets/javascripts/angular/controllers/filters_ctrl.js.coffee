betterCherkasy.controller 'FiltersCtrl', [
  '$scope', '$location'
  ($scope, $location) ->
    $scope.currentLocation = null
    $scope.googleMapReady = false
    $scope.filters = {}

    $scope.placeMarker = (location) ->
      $scope.currentMarker.setMap(null) if $scope.currentMarker
      marker = new (google.maps.Marker)(
        position: location
        map: $scope.map
        title: 'клікніть по маркеро щоб отримати адресу'
      )
      $scope.currentMarker = marker
      infowindow = new (google.maps.InfoWindow)
      geocoder = new (google.maps.Geocoder)
      $scope.filters.lat = location.lat()
      $scope.filters.lng = location.lng()
      latlng = new (google.maps.LatLng)(location.lat(), location.lng())
      geocoder.geocode { 'latLng': latlng, 'language': 'ua' }, (results, status) ->
        if status == google.maps.GeocoderStatus.OK
          infowindow.setContent(results[0].formatted_address)
          infowindow.open $scope.map, marker
          google.maps.event.addListener marker, 'click', ->
            infowindow.open $scope.map, marker
      google.maps.event.addListener infowindow, 'closeclick', ->
        marker.setMap null
        $scope.filters.lat = null
        $scope.filters.lng = null
      google.maps.event.addListener marker, 'dblclick', ->
        marker.setMap null
        $scope.filters.lat = null
        $scope.filters.lng = null

    initGoogleMap = ->
      return if $scope.googleMapReady
      myLatlng = new (google.maps.LatLng)(49.4344984, 32.0618366)
      mapOptions =
        zoom: 13
        center: myLatlng
      canvas = document.getElementById('map-canvas')
      $scope.map = new (google.maps.Map)(canvas, mapOptions)
      google.maps.event.addListener $scope.map, 'click', (event) ->
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

    $scope.applyFilter = ->
      $location.path('/events').search('lat', $scope.filters.lat).search('lng', $scope.filters.lng)
      hideFilterPanel()
      return

]

