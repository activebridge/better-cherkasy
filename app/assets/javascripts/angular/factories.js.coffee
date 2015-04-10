betterCherkasy.factory 'Event', ['$resource', ($resource) ->
  $resource('/events/:id/:action', {id: '@id'},
    update:
      method: 'PUT'
    edit:
      method: 'GET'
      params:
        action: 'edit'
  )
]

betterCherkasy.factory 'User', ['$resource', ($resource) ->
  $resource('/users/:id', {id: '@id'}, {update: {method: 'PUT'}})
]

betterCherkasy.factory 'Session', ['$resource', ($resource) ->
  $resource('/sessions/:id', {id: '@id'}, {update: {method: 'PUT'}})
]

betterCherkasy.factory 'EventVote', ['$resource', ($resource) ->
  $resource('/event_votes/:id', {id: '@id'}, {update: {method: 'PUT'}})
]

betterCherkasy.factory 'Subscription', ['$resource', ($resource) ->
  $resource('/subscriptions/:id', {id: '@id'})
]

betterCherkasy.factory 'Comment', ['$resource', ($resource) ->
  $resource('/events/:event_id/comments/:id', {event_id: '@event_id', id: '@id'})
]
