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
      $scope.filters.lat = $scope.filters.mapLat = location.lat()
      $scope.filters.lng = $scope.filters.mapLng = location.lng()
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
          lat = position.coords.latitude
          lng = position.coords.longitude
          $scope.filters.lat = $scope.filters.myLat = lat
          $scope.filters.lng = $scope.filters.myLng = lng
          latlng = new (google.maps.LatLng)(lat, lng)
          geocoder = new (google.maps.Geocoder)
          geocoder.geocode { 'latLng': latlng, 'language': 'ua' }, (results, status) ->
            if status == google.maps.GeocoderStatus.OK
              $scope.currentLocation = results[0].formatted_address
              $('#events-filters.slide-down-panel img.ajax-loader').hide()
              $scope.$apply()
      else
        $scope.currentLocation = 'Geolocation is not supported by this browser.'
      return

    $scope.init = ->
      fetchCurrentGeoLocation()

    turnOnOption = (elem) ->
      $('span.option').removeClass('active')
      elem.addClass('active')

    $scope.showMap = ($event) ->
      turnOnOption($($event.currentTarget))
      $('.map-container').slideDown 1000, ->
        initGoogleMap()
      $scope.filters.lat = $scope.filters.mapLat
      $scope.filters.lng = $scope.filters.mapLng
      return

    $scope.nearMe = ($event) ->
      turnOnOption($($event.currentTarget))
      $('.map-container').slideUp(1000)
      $scope.filters.lat = $scope.filters.myLat
      $scope.filters.lng = $scope.filters.myLng
      return

    $scope.applyFilter = ->
      $location.path('/events').search('lat', $scope.filters.lat)
        .search('lng', $scope.filters.lng)
        .search('radius', $('input.slider').data('slider').getValue())
      hidePanel()
      return

]

