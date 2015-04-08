betterCherkasy.controller 'NewEventCtrl', [
  '$scope', 'Event', '$http', '$location'
  ($scope, Event, $http, $location) ->
    $scope.newEvent = {}
    $scope.newEvent.regions = []

    $scope.options = ->
      {language: 'uk'}

    $scope.loadTags = (query) ->
      $http.get('/tags?query=' + query)

    $scope.add = ->
      $scope.newEvent['auth_token'] = getAuthToken()
      Event.save($scope.newEvent,
        (response) ->
          $location.path('/')
      )

    $scope.updateRegions = (name) ->
      index = $scope.newEvent.regions.indexOf(name)
      if index > -1
        $scope.newEvent.regions.splice(index, 1)
      else
        $scope.newEvent.regions.push(name)
      $scope.$apply()

    $scope.cancel = ->
      $location.path('/')

    initializeGoogleMaps = ->
      myLatlng = new (google.maps.LatLng)(49.4344984, 32.0618366)
      mapOptions =
        zoom: 13
        center: myLatlng
      map = new (google.maps.Map)(document.getElementById('map-canvas'), mapOptions)
      kmlLayer = new (google.maps.KmlLayer)(
        url: 'https://drive.google.com/uc?export=download&id=0B3l_DlumkLHhY1A2S0tRbEJpa1U'
        suppressInfoWindows: true
        preserveViewport: true
        map: map)
      google.maps.event.addListener kmlLayer, 'click', (kmlEvent) ->
        $scope.updateRegions(kmlEvent.featureData.name)

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
