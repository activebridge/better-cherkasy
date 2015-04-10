betterCherkasy.factory 'eventFormDecorator', [
  '$http', '$location'
  ($http, $location) ->

    ($scope) ->
      $scope.loadTags = (query) ->
        $http.get('/tags?query=' + query)

      initializeGoogleMaps = ->
        currentMarker = null
        placeMarker = (location) ->
          currentMarker.setMap(null) if currentMarker
          marker = new (google.maps.Marker)(
            position: location
            map: map
            title: 'клікніть по маркеро щоб отримати адресу'
          )
          currentMarker = marker
          infowindow = new (google.maps.InfoWindow)
          geocoder = new (google.maps.Geocoder)
          $scope.newEvent.lat = location.lat()
          $scope.newEvent.lng = location.lng()
          latlng = new (google.maps.LatLng)(location.lat(), location.lng())
          geocoder.geocode { 'latLng': latlng, 'language': 'ua' }, (results, status) ->
            if status == google.maps.GeocoderStatus.OK
              infowindow.setContent(results[0].formatted_address)
              $scope.newEvent.address = results[0].formatted_address
              infowindow.open map, marker
              google.maps.event.addListener marker, 'click', ->
                infowindow.open map, marker
          google.maps.event.addListener infowindow, 'closeclick', ->
            marker.setMap null
          google.maps.event.addListener marker, 'dblclick', ->
            marker.setMap null
        myLatlng = new (google.maps.LatLng)(49.4344984, 32.0618366)
        mapOptions =
          zoom: 13
          center: myLatlng
        map = new (google.maps.Map)(document.getElementById('map-canvas'), mapOptions)
        google.maps.event.addListener map, 'click', (event) ->
          placeMarker event.latLng
          return

      setTimeout ( ->
        $('.timepicker').timepicker
          minuteStep: 5

        $('.datepicker').datepicker
          autoclose: true
          todayHighlight: true
          startDate: new Date()
          format: 'dd-mm-yyyy'

        initializeGoogleMaps()

      ), 300
]
