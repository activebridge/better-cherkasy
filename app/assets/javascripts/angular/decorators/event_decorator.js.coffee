betterCherkasy.factory 'eventDecorator', [
  'EventUser', '$sce', 'Subscription'
  (EventUser, $sce, Subscription) ->

    ($scope) ->
      $scope.up = (event) ->
        markEventAsRated(event, true)

      $scope.down = (event) ->
        markEventAsRated(event, false)

      $scope.userSignedIn = ->
        userSignedIn()

      markEventAsRated = (event, rating) ->
        EventUser.update(
          id: event.id
          auth_token: getAuthToken()
          like: rating
          , (response) ->
            event.rating = response.rating
        )

      $scope.descriptionHtml = (event) ->
        $sce.trustAsHtml(event.description)

      $scope.subscribe = (event) ->
        Subscription.save
          event_id: event.id
          auth_token: getAuthToken()
        , (response) ->
          event.subscriptions.push response

      $scope.unsubscribe = (event) ->
        userId = getCurrentUser().id
        event.subscriptions.forEach((subscription, index) ->
          if subscription.user.id == userId
            Subscription.delete
              id: subscription.id
              auth_token: getAuthToken()
            , (success) ->
              event.subscriptions.splice index, 1
        )

      $scope.subscribed = (event) ->
        userId = getCurrentUser().id
        return false unless event.subscriptions
        for subscription in event.subscriptions
          if subscription.user.id == userId
            return true
        return false
]