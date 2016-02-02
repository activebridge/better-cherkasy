betterCherkasy.controller 'EventsCtrl', [
  '$scope'
  'MapService'
  ($scope, MapService) ->
    angular.extend($scope, MapService($scope))
    $scope.init()
]
