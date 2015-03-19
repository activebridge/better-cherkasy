betterCherkasy.factory 'eventDecorator', [
  'EventVote', '$sce', 'Subscription'
  (EventVote, $sce, Subscription) ->

    ($scope) ->
      $scope.up = (event) ->
        markEventAsRated(event, true)

      $scope.down = (event) ->
        markEventAsRated(event, false)

      $scope.userSignedIn = ->
        userSignedIn()

      markEventAsRated = (event, rating) ->
        EventVote.update(
          id: event.id
          auth_token: getAuthToken()
          vote: rating
          , (response) ->
            event.likes = response.likes
            event.dislikes = response.dislikes
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
