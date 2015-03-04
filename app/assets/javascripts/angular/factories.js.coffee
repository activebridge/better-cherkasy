betterCherkasy.factory 'Event', ['$resource', ($resource) ->
  $resource('/events/:id', {id: '@id'}, {update: {method: 'PUT'}})
]
