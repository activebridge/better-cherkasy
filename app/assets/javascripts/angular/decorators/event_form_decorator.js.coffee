betterCherkasy.factory 'eventFormDecorator', [
  '$http', '$location'
  ($http, $location) ->

    ($scope) ->
      $scope.loadTags = (query) ->
        $http.get('/tags?query=' + query)

      $scope.currentMarker = null

      $scope.clearLocation = ->
        $scope.newEvent.lat = null
        $scope.newEvent.lng = null
        $scope.newEvent.address = null

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
        $scope.newEvent.lat = location.lat()
        $scope.newEvent.lng = location.lng()
        latlng = new (google.maps.LatLng)(location.lat(), location.lng())
        geocoder.geocode { 'latLng': latlng, 'language': 'ua' }, (results, status) ->
          if status == google.maps.GeocoderStatus.OK
            infowindow.setContent(results[0].formatted_address)
            $scope.newEvent.address = results[0].formatted_address
            infowindow.open $scope.map, marker
            google.maps.event.addListener marker, 'click', ->
              infowindow.open $scope.map, marker
        google.maps.event.addListener infowindow, 'closeclick', ->
          marker.setMap null
          $scope.clearLocation()
        google.maps.event.addListener marker, 'dblclick', ->
          marker.setMap null
          $scope.clearLocation()

      initGoogleMap = ->
        myLatlng = new (google.maps.LatLng)(49.4344984, 32.0618366)
        mapOptions =
          zoom: 13
          center: myLatlng
        $scope.map = new (google.maps.Map)(document.getElementById('map-canvas'), mapOptions)
        google.maps.event.addListener $scope.map, 'click', (event) ->
          $scope.placeMarker event.latLng
          return

      setTimeout ( ->
        $('.timepicker').timepicker
          minuteStep: 5

        $('.datepicker').datepicker
          autoclose: true
          todayHighlight: true
          startDate: new Date()
          format: 'dd-mm-yyyy'

        initGoogleMap()

      ), 300
]
