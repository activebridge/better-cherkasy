betterCherkasy.factory 'Event', ['$resource', ($resource) ->
  $resource('/events/:id', {id: '@id'}, {update: {method: 'PUT'}})
]

betterCherkasy.factory 'User', ['$resource', ($resource) ->
  $resource('/users/:id', {id: '@id'}, {update: {method: 'PUT'}})
]

betterCherkasy.factory 'Session', ['$resource', ($resource) ->
  $resource('/sessions/:id', {id: '@id'}, {update: {method: 'PUT'}})
]