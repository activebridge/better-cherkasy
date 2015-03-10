betterCherkasy.factory 'Event', ['$resource', ($resource) ->
  $resource('/events/:id', {id: '@id'}, {update: {method: 'PUT'}})
]

betterCherkasy.factory 'User', ['$resource', ($resource) ->
  $resource('/users/:id', {id: '@id'}, {update: {method: 'PUT'}})
]

betterCherkasy.factory 'Session', ['$resource', ($resource) ->
  $resource('/sessions/:id', {id: '@id'}, {update: {method: 'PUT'}})
]

betterCherkasy.factory 'EventUser', ['$resource', ($resource) ->
  $resource('/event_users/:id', {id: '@id'}, {update: {method: 'PUT'}})
]

betterCherkasy.factory 'Subscription', ['$resource', ($resource) ->
  $resource('/subscriptions/:id', {id: '@id'})
]
