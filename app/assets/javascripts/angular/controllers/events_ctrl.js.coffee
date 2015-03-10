betterCherkasy.controller 'EventsCtrl', [
  '$scope', 'Event', '$modal', 'EventUser', 'Subscription'
  ($scope, Event, $modal, EventUser, Subscription) ->

    init = ->
      $scope.events = Event.query ->

    $scope.delete = (event_id, index) ->
      if confirm 'Ви впевнені?'
        Event.delete
          id: event_id
          auth_token: getAuthToken()
        , (success) ->
            $scope.events.splice(index, 1)

    $scope.openModal = ->
      modalInstance = $modal.open(
        template: $('#new-event-modal').html(),
        controller: 'NewEventCtrl',
        resolve:
          events: ->
            $scope.events
      )

    markEventAsRated = (event, rating) ->
      EventUser.update(
        id: event.id
        auth_token: getAuthToken()
        like: rating
        , (response) ->
          event.rating = response.rating
      )

    $scope.up = (event) ->
      markEventAsRated(event, true)

    $scope.down = (event) ->
      markEventAsRated(event, false)

    $scope.userSignedIn = ->
      userSignedIn()

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
      for subscription in event.subscriptions
        if subscription.user.id == userId
          return true
      return false

    init()
]

